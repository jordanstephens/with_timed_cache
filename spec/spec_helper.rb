require "rspec"
require "with_timed_cache"

shared_context :with_timed_cache do
  include WithTimedCache
end

