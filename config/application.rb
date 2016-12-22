require_relative "boot"

require "rails/all"
require "carrierwave"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Wsm02
  class Application < Rails::Application
    config.i18n.default_locale = :en
    config.i18n.available_locales = [:vi, :en, :ja]
  end
end
