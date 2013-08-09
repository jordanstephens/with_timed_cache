require 'spec_helper'

describe WithTimedCache::JSONCache do
  it "knows it's local class name" do
    WithTimedCache::JSONCache.local_class_name.should == "JSONCache"
  end

  it "has a file_extension" do
    WithTimedCache::JSONCache.file_extension.should == "json"
  end

  it "should have a filename with the '.json' extension" do
    cache = WithTimedCache::JSONCache.new(:foo)
    (cache.filename =~ /^.+\.json$/).should be_true
  end
end

