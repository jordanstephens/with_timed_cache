require 'spec_helper'

describe WithTimedCache do
  include_context :with_timed_cache

  before(:all) do
    @cache_directory = "spec/data/tmp"
    clean_cache_directory
  end

  after(:all) do
    clean_cache_directory
  end

  it "caches data for a defined max_age" do
    original_val = "original value"
    updated_val = "updated value"
    2.times do |i|
      data = with_timed_cache(:max_age_1, location: @cache_directory, max_age: 1.minute) do
        i == 0 ? original_val : updated_val
      end
      expect(data).to eql(original_val)
    end
  end

  it "updates the cache after a defined max_age" do
    original_val = "original value"
    updated_val = "updated value"
    data = nil
    2.times do |i|
      data = with_timed_cache(:max_age_2, location: @cache_directory, max_age: 1.second) do
        i == 0 ? original_val : updated_val
      end
      if i == 0
        expect(data).to eql(original_val)
        sleep 1.5 # sleep longer than max_age
      end
    end
    expect(data).to eql(updated_val)
  end

  it "caches marshaled data to a file" do
    key = :foo
    filename = "#{key}_cache"
    data = [1, 2, 3]

    cached_data = with_timed_cache(key, location: @cache_directory) { data }
    expect(cached_data).to eql(data)
    expect(File.exists?(File.join(@cache_directory, filename))).to be true

    raw_cache_data = File.read(File.join(@cache_directory, filename))
    expect(Marshal.load(raw_cache_data)).to eql(data)
  end

  it "lets you store cache data as json" do
    key = :json
    filename = "#{key}_cache.json"
    filepath = File.join(@cache_directory, filename)
    data = { foo: 'bar', baz: 'qux' }

    cached_data = with_timed_cache(key, location: @cache_directory, format: :json) { data }
    expect(cached_data).to eql(data)
    expect(File.exists?(filepath)).to be true

    raw_cache_data = File.read(filepath)
    expect(JSON.parse(raw_cache_data, symbolize_names: true)).to eql(data)
  end

  it "lets you store cache data as yaml" do
    key = :yaml
    filename = "#{key}_cache.yml"
    filepath = File.join(@cache_directory, filename)
    data = { foo: 'bar', baz: 'qux' }

    cached_data = with_timed_cache(key, location: @cache_directory, format: :yaml) { data }
    expect(cached_data).to eql(data)
    expect(File.exists?(filepath)).to be true

    raw_cache_data = File.read(filepath)
    expect(YAML.load_file(filepath)).to eql(data)
  end

  it "returns last cached data if present when an exception is raised" do
    string = "lorem ipsum dolor sit amet"
    data = nil
    2.times do |i|
      data = with_timed_cache(:exception, location: @cache_directory, max_age: 1.second) do
        if i == 0
          string
        else
          raise Exception
        end
      end
      sleep 1.5 if i == 0
    end
    expect(data).to eql(string)
  end

  it "returns nil when an exception is raised if no previous cache is present" do
    data = with_timed_cache(:exception_nil, location: @cache_directory, max_age: 1.second) do
      raise Exception
    end
    expect(data).to be nil
  end

  def clean_cache_directory
    FileUtils.rm_f(Dir.glob(File.join(@cache_directory, "*")))
  end
end

