class RateLimiter
  MAX_REQUESTS =
  TIME_WINDOW = 1.minute

  def self.exceeded?(ip_address)

    cache_key = "rate_limit:#{ip_address}"
    request_count = Rails.cache.fetch(cache_key, expires_in: TIME_WINDOW) { 0 }
    request_count += 1

    Rails.cache.write(cache_key, request_count, expires_in: TIME_WINDOW)
    
    request_count > MAX_REQUESTS
  end

  def self.status(ip_address)
    request_count = Rails.cache.read("rate_limit:#{ip_address}") || 0
    remaining_requests = MAX_REQUESTS - request_count
    exceeded = request_count > MAX_REQUESTS

    {
      exceeded: exceeded,
      remaining: remaining_requests,
      exceeded_count: request_count
    }
  end
end

