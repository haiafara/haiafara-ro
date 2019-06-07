redis_database = ENV['REDIS_DATABASE'].present? ? ENV['REDIS_DATABASE'].to_s : '2'

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://127.0.0.1:6379/#{redis_database}" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://127.0.0.1:6379/#{redis_database}" }
end