require 'spec_helper'

describe WithTimedCache::YAMLCache do
  it "knows it's local class name" do
    expect(WithTimedCache::YAMLCache.local_class_name).to eql("YAMLCache")
  end

  it "has a file_extension" do
    expect(WithTimedCache::YAMLCache.file_extension).to eql("yml")
  end

  it "should have a filename with the '.yml' extension" do
    cache = WithTimedCache::YAMLCache.new(:foo)
    expect(!!(cache.filename =~ /^.+\.yml$/)).to be true
  end
end

