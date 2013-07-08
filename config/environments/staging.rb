GradeCraft::Application.configure do
  config.action_controller.default_url_options = { :host => 'gradecraft.townstage.com' }
  config.action_controller.perform_caching = true
  config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect'
  config.action_mailer.default_url_options = { :host => 'gradecraft.townstage.com' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :authentication => :plain,
    :address => 'smtp.mandrillapp.com',
    :port => 587,
    :domain => 'gradecraft.com',
    :user_name => ENV['MANDRILL_USERNAME'],
    :password => ENV['MANDRILL_PASSWORD']
  }
  config.active_support.deprecation = :notify
  config.assets.compile = false
  config.assets.compress = true
  config.assets.digest = true
  config.cache_classes = false
  config.consider_all_requests_local = false
  config.eager_load = true
  config.force_ssl = true
  config.i18n.fallbacks = true
  config.log_formatter = ::Logger::Formatter.new
  config.log_level = :info
  config.serve_static_assets = false
end
