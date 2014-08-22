require 'spec_helper'

describe WithTimedCache::Cache do
  it "knows it's local class name" do
    expect(WithTimedCache::Cache.local_class_name).to eql("Cache")
  end

  it "has an empty file extension" do
    expect(WithTimedCache::Cache.file_extension).to be_empty
  end

  it "should have a filename with no extension by default" do
    cache = WithTimedCache::Cache.new(:foo)
    expect(!!(cache.filename =~ /^.+\..+$/)).to be false
  end
end

