# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Haiafara
  # The almighty application
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified
    # in this file.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.active_job.queue_adapter = :sidekiq

    # Locales
    config.i18n.default_locale = :ro
    config.i18n.fallbacks = [I18n.default_locale]

    config.filter_parameters << :password
  end
end
