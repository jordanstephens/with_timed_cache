require 'spec_helper'

describe WithTimedCache::JSONCache do
  it "knows it's local class name" do
    expect(WithTimedCache::JSONCache.local_class_name).to eql("JSONCache")
  end

  it "has a file_extension" do
    expect(WithTimedCache::JSONCache.file_extension).to eql("json")
  end

  it "should have a filename with the '.json' extension" do
    cache = WithTimedCache::JSONCache.new(:foo)
    expect(!!(cache.filename =~ /^.+\.json$/)).to be true
  end
end

