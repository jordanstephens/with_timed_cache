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
      data.should == original_val
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
        data.should == original_val
        sleep 1.5 # sleep longer than max_age
      end
    end
    data.should == updated_val
  end

  it "caches marshaled data to a file" do
    key = :foo
    filename = "#{key}_cache"
    data = [1, 2, 3]

    cached_data = with_timed_cache(key, location: @cache_directory) { data }
    cached_data.should == data
    File.exists?(File.join(@cache_directory, filename)).should be_true

    raw_cache_data = File.read(File.join(@cache_directory, filename))
    Marshal.load(raw_cache_data).should == data
  end

  it "lets you store cache data as json" do
    key = :json
    filename = "#{key}_cache.json"
    filepath = File.join(@cache_directory, filename)
    data = { foo: 'bar', baz: 'qux' }

    cached_data = with_timed_cache(key, location: @cache_directory, format: :json) { data }
    cached_data.should == data
    File.exists?(filepath).should be_true

    raw_cache_data = File.read(filepath)
    JSON.parse(raw_cache_data, symbolize_names: true).should == data
  end

  it "lets you store cache data as yaml" do
    key = :yaml
    filename = "#{key}_cache.yml"
    filepath = File.join(@cache_directory, filename)
    data = { foo: 'bar', baz: 'qux' }

    cached_data = with_timed_cache(key, location: @cache_directory, format: :yaml) { data }
    cached_data.should == data
    File.exists?(filepath).should be_true

    raw_cache_data = File.read(filepath)
    YAML.load_file(filepath).should == data
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
    data.should == string
  end

  it "returns nil when an exception is raised if no previous cache is present" do
    data = with_timed_cache(:exception_nil, location: @cache_directory, max_age: 1.second) do
      raise Exception
    end
    data.should be_nil
  end

  def clean_cache_directory
    FileUtils.rm_f(Dir.glob(File.join(@cache_directory, "*")))
  end
end

