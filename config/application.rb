# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GithubQuality
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    routes.default_url_options = { host: ENV['BASE_URL'] }
    Rails.application.default_url_options = { host: ENV['BASE_URL'] }
    Rails.application.routes.default_url_options = { host: ENV['BASE_URL'] }
    Rails.application.configure do
      routes.default_url_options[:host] = ENV['BASE_URL']
    end
    # config.action_controller.default_protect_from_forgery = false
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
