Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDIS_URL"], namespace: "call_for_practice" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDIS_URL"], namespace: "call_for_practice" }
end
