require_relative "boot"

require "rails/all"
require "carrierwave"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Wsm02
  class Application < Rails::Application
  end
end
