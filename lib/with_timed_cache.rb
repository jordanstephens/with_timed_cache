require "with_timed_cache/version"
require "with_timed_cache/caches"

module WithTimedCache
  def with_timed_cache(key, opts = {})
    cache = Caches.find_or_create(key, opts)

    if cache.exists? && !cache.stale?
      data = cache.read
    else
      begin
        data = yield
        cache.write(data)
      rescue Exception => e
        data = cache.read rescue nil
      end
    end
    data
  end
end

