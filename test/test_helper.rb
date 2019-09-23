ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/minitest'
require 'public_activity/testing'
require 'minitest/retry'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

PublicActivity.enabled = false

Capybara.server = :puma, { Slient: true }
Capybara.server_host = "0.0.0.0"
Capybara.server_port = 3000

server = Capybara.current_session.server
Capybara.app_host = "http://#{ENV.fetch('SELENIUM_APP_HOST') { 'localhost' }}:#{server.port}" if server

Capybara.raise_server_errors = true

Capybara.default_max_wait_time = 10