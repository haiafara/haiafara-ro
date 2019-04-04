Raven.configure do |config|
  config_file = "#{Rails.root.to_s}/config/sentry.yml"
  config.dsn = File.exists?(config_file) ? YAML.load_file(config_file)['dsn'] : nil
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
end
