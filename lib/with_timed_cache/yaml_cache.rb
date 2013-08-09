require "with_timed_cache/cache"
require "yaml"

module WithTimedCache
  class YAMLCache < Cache

    @file_extension = "yml"

    def initialize(key, opts = {})
      super
      filename = "#{key}_cache.yml"
      @location = opts[:location] || "tmp/#{filename}"
      @location = File.join(@location, "#{filename}") if File.directory?(@location)
    end

    def read
      YAML.load @location
    end

    def write(data)
      File.open(@location, 'w') { |f| f.write data.to_yaml }
    end

    def self.file_extension
      "yml"
    end
  end
end

