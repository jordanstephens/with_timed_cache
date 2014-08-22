require 'spec_helper'

describe WithTimedCache::YAMLCache do
  it "knows it's local class name" do
    WithTimedCache::YAMLCache.local_class_name.should == "YAMLCache"
  end

  it "has a file_extension" do
    WithTimedCache::YAMLCache.file_extension.should == "yml"
  end

  it "should have a filename with the '.yml' extension" do
    cache = WithTimedCache::YAMLCache.new(:foo)
    (cache.filename =~ /^.+\.yml$/).should be_true
  end
end

