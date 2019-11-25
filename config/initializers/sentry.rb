if Rails.env.production?
  Raven.configure do |config|
    config.dsn = ENV.fetch('SENTRY_DSN')
    config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
    config.async = lambda { |event| SentryJob.perform_later(event) }
  end
end
