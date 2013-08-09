require "with_timed_cache/cache"
require "json"

module WithTimedCache
  class JSONCache < Cache
    def initialize(key, opts = {})
      super
      @location = opts[:location] || File.join("tmp", filename)
      @location = File.join(@location, filename) if File.directory?(@location)
    end

    def read
      JSON.parse(File.read(@location), symbolize_names: true)
    end

    def write(data)
      File.open(@location, 'w') { |f| f.write data.to_json }
    end
  end
end

