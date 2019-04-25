Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://127.0.0.1:6379/2' }
end