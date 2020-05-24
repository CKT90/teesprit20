require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)


module Tea
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib)
    config.assets.paths << Rails.root.join("app", "assets", "fonts")

    config.time_zone = 'Kuala Lumpur'
    config.active_record.default_timezone = :utc
    config.active_record.time_zone_aware_attributes = false

    config.after_initialize do
       
    end
  end
end
