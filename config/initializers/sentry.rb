Raven.configure do |config|
  config.dsn = YAML.load_file("#{Rails.root.to_s}/config/sentry.yml")['dsn']
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
end
