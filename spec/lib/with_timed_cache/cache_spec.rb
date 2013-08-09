require 'spec_helper'

describe WithTimedCache::Cache do
  it "knows it's local class name" do
    WithTimedCache::Cache.local_class_name.should == "Cache"
  end

  it "has an empty file extension" do
    WithTimedCache::Cache.file_extension.should be_empty
  end

  it "should have a filename with no extension by default" do
    cache = WithTimedCache::Cache.new(:foo)
    (cache.filename =~ /^.+\..+$/).should be_false
  end
end

