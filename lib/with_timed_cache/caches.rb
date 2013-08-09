
require "with_timed_cache/json_cache"
require "with_timed_cache/yaml_cache"

module WithTimedCache
  class InvalidCacheFormatException < Exception; end

  class Caches

    @caches = []

    class << self
      def find_or_create(key, opts = {})
        cache = find(key) || create(key, opts)
        @caches << cache
        cache
      end

      def find(key)
        @caches.select { |c| c.key == key }.first
      end

      def create(key, opts = {})
        cache_class(opts[:format]).new(key, opts)
      end

      def cache_class(format = "")
        format = format.to_s.upcase
        begin
          Object.const_get("WithTimedCache::#{format}Cache")
        rescue
          raise WithTimedCache::InvalidCacheFormatException
        end
      end
    end
  end
end

