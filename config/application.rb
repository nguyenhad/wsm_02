require_relative "boot"

require "rails/all"
require "carrierwave"
Bundler.require(*Rails.groups)

module Wsm02
  class Application < Rails::Application
  end
end
