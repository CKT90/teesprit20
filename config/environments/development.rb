Rails.application.configure do
  # Verifies that versions and hashed value of the package contents in the project's package.json
config.webpacker.check_yarn_integrity = true


  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false
  # Do not eager load code on boot.
  config.eager_load = false
  #config.assets.prefix = '/dev-assets'
  config.serve_static_assets = true
  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true

  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_mailer.perform_caching = false
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => 'public, max-age=172800'
    }
  else
    config.action_controller.perform_caching = false
    config.action_mailer.perform_caching = false
    config.cache_store = :null_store
  end


  # Don't care if the mailer can't send.
  config.action_mailer.show_previews = true
  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load
  config.webpacker.check_yarn_integrity = false
  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = false

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true
  config.action_mailer.perform_deliveries = true


  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  host = 'localhost:3000'
  config.action_mailer.default_url_options = { host: host }
  ActionMailer::Base.smtp_settings = {
      :address              => 'smtp.gmail.com',
      :port                 => '587',
      :authentication       => :plain,
      :user_name            => ENV["GMAIL_USERNAME"],
      :password             => ENV["GMAIL_PASSWORD"],
      :domain               => 'localhost:3000',
      :enable_starttls_auto => true
  }
  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true



  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Enable the asset pipeline
end
