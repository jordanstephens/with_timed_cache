require 'spec_helper'

describe WithTimedCache::Caches do
  describe ".find_or_create" do
    it "will not create a cache twice, but will retrieve a cache by it's key if it exists" do
      key = :find_or_create
      first_ref = WithTimedCache::Caches.find_or_create(key)
      second_ref = WithTimedCache::Caches.find_or_create(key)
      first_ref.eql?(second_ref).should be_true
    end
  end

  describe ".cache_class" do
    it "will return the constant of the cache class for the given format" do
      WithTimedCache::Caches.cache_class(:json).should == WithTimedCache::JSONCache
      WithTimedCache::Caches.cache_class("json").should == WithTimedCache::JSONCache
      WithTimedCache::Caches.cache_class(:yaml).should == WithTimedCache::YAMLCache
      WithTimedCache::Caches.cache_class("").should == WithTimedCache::Cache
      WithTimedCache::Caches.cache_class.should == WithTimedCache::Cache
    end

    it "will return the constant of the cache class for the given format" do
      expect {
        WithTimedCache::Caches.cache_class(:foobar).should == WithTimedCache::JSONCache
      }.to raise_error WithTimedCache::InvalidCacheFormatException
    end
  end
end

