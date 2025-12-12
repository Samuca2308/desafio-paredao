class Rack::Attack
  throttle('req/ip', limit: 5, period: 1.minute) do |request|
    request.ip
  end

  self.cache.store = ActiveSupport::Cache::MemoryStore.new

  blocklist('block all IPs') do |request|
    false
  end
end
