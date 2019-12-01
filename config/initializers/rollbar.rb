Rollbar.configure do |config|
  # Without configuration, Rollbar is enabled in all environments.
  # To disable in specific environments, set config.enabled=false.

  config.access_token = ENV['ROLLBAR_ACCESS_TOKEN']

  # Here we'll disable in 'test':
  if Rails.env.test? || Rails.env.development?
    config.enabled = false
    config.use_sidekiq

    config.js_enabled = true
    config.js_options = {
      accessToken: ENV['ROLLBAR_CLIENT_ACCESS_TOKEN'],
      captureUncaught: true,
      captureUnhandledRejections: true,
      payload: { environment: config.environment }
    }
  end

  config.environment = ENV['ROLLBAR_ENV'].presence || Rails.env
end
