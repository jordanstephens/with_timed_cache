require "active_support/core_ext/numeric/time"

module WithTimedCache
  class Cache

    attr_reader :key, :location, :max_age

    def initialize(key, opts = {})
      @key = key
      @max_age = opts[:max_age] || 1.hour
      @location = opts[:location] || File.join("tmp", filename)
      @location = File.join(@location, filename) if File.directory?(@location)
      self
    end

    def stale?
      File.mtime(@location) < @max_age.ago
    end

    def exists?
      File.exists? @location
    end

    def read
      Marshal.load(File.read(@location))
    end

    def write(data)
      File.open(@location, 'w') { |f| f.write Marshal.dump(data) }
    end

    def filename
      extension = self.class.file_extension
      filename = "#{@key}_cache"
      filename += ".#{extension}" unless extension.empty?
      filename
    end

    def self.file_extension
      @file_extension ||= self.local_class_name.sub(/Cache$/, "").downcase
    end

    def self.local_class_name
      @local_class_name ||= self.to_s.split("::").last rescue self.to_s
    end
  end
end
