require "test_helper"

Minitest::Retry.use!
class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Warden::Test::Helpers
  driven_by :selenium, using: :headless_chrome, options: { args: ["headless", "disable-gpu", "no-sandbox", "disable-dev-shm-usage"] }

  def setup
    Warden.test_mode!
  end

  def teardown
    Warden.test_reset!
  end
end
