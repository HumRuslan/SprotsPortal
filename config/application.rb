require_relative "boot"

require "rails/all"

require 'csv'

require 'activerecord-import/base'

if Rails.env.production?
  require 'activerecord-import/active_record/adapters/postgresql_adapter'
else
  require 'activerecord-import/active_record/adapters/mysql2_adapter'
end

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SportsPortal
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    config.generators do |g|
      g.template_engine :haml
    end
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.i18n.available_locales = %i[en uk]
    config.i18n.default_locale = :en
  end
end
