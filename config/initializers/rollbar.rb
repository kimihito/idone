Rollbar.configure do |config|
  # Without configuration, Rollbar is enabled in all environments.
  # To disable in specific environments, set config.enabled=false.

  config.access_token = ENV['ROLLBAR_ACCESS_TOKEN']
  config.use_sidekiq

  config.js_enabled = ENV.has_value?('ROLLBAR_CLIENT_ACCESS_TOKEN')
  config.js_options = {
    accessToken: ENV['ROLLBAR_CLIENT_ACCESS_TOKEN'],
    captureUncaught: true,
    captureUnhandledRejections: true,
    payload: { environment: config.environment }
  }

  if Rails.env.test? || Rails.env.development?
    config.enabled = false
    config.js_enabled = false
  end

  config.environment = ENV['ROLLBAR_ENV'].presence || Rails.env
end
