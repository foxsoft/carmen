Clearance.configure do |config|
  config.allow_sign_up = false
  config.mailer_sender = ENV.fetch('CLEARANCE_MAILER_SENDER')
  config.routes = false
  config.rotate_csrf_on_sign_in = true
  config.user_model = Account
  config.cookie_expiration = lambda { |cookies| 15.minutes.from_now.utc }
  config.httponly = true
end
