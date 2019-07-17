SMTP_SETTINGS = {
  user_name:            ENV.fetch("SMTP_USERNAME"),
  password:             ENV.fetch("SMTP_PASSWORD"),
  address:              ENV.fetch("SMTP_ADDRESS"),
  domain:               ENV.fetch("SMTP_DOMAIN"),
  port:                 ENV.fetch("SMTP_PORT"),
  authentication:       ENV.fetch("SMTP_AUTHENTICATION").to_sym,
  enable_starttls_auto: true,
}

Rails.application.configure do
  config.action_mailer.perform_caching = false

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = SMTP_SETTINGS
  config.action_mailer.default_url_options = { host: ENV.fetch("MAIL_HOST") }
end
