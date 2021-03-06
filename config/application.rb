require_relative 'boot'

require 'rails/all'
require 'action_view/component/base'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Idone
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.time_zone = "Tokyo"

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.middleware.insert_after ActionDispatch::Static, Rack::Deflater
    config.middleware.use Rack::Attack
  end
end
