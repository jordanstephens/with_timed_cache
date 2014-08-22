require 'spec_helper'

describe WithTimedCache::Caches do
  describe ".find_or_create" do
    it "will not create a cache twice, but will retrieve a cache by it's key if it exists" do
      key = :find_or_create
      first_ref = WithTimedCache::Caches.find_or_create(key)
      second_ref = WithTimedCache::Caches.find_or_create(key)
      expect(first_ref.eql?(second_ref)).to be true
    end
  end

  describe ".cache_class" do
    it "will return the constant of the cache class for the given format" do
      expect(WithTimedCache::Caches.cache_class(:json)).to eql(WithTimedCache::JSONCache)
      expect(WithTimedCache::Caches.cache_class("json")).to eql(WithTimedCache::JSONCache)
      expect(WithTimedCache::Caches.cache_class(:yaml)).to eql(WithTimedCache::YAMLCache)
      expect(WithTimedCache::Caches.cache_class("")).to eql(WithTimedCache::Cache)
      expect(WithTimedCache::Caches.cache_class).to eql(WithTimedCache::Cache)
    end

    it "will return the constant of the cache class for the given format" do
      expect {
        WithTimedCache::Caches.cache_class(:foobar)
      }.to raise_error WithTimedCache::InvalidCacheFormatException
    end
  end
end

