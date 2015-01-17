module FrancisCms
  class Engine < ::Rails::Engine
    isolate_namespace FrancisCms

    config.generators do |g|
      g.test_framework :rspec
    end

    config.autoload_paths << File.expand_path('../../', __FILE__)

    config.before_initialize do
      ActiveSupport.on_load :action_controller do
        helper FrancisCms::Engine.helpers
      end
    end

    config.before_configuration do |app|
      app.config.francis_cms = ActiveSupport::OrderedOptions.new

      app.config.francis_cms.logged_in_method = :logged_in?
      app.config.francis_cms.login_path       = '/login'

      app.config.francis_cms.site_url         = 'http://example.com'
      app.config.francis_cms.site_title       = 'FrancisCMS Demo Site'
      app.config.francis_cms.site_description = 'This is the default site description for a new FrancisCMS-powered website.'
      app.config.francis_cms.site_language    = 'en-US'

      app.config.francis_cms.user_name        = 'Jane Doe'
      app.config.francis_cms.user_email       = 'jane@example.com'
      app.config.francis_cms.user_avatar      = 'http://www.placecage.com/180/180'

      app.config.francis_cms.license_title    = 'Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International'
      app.config.francis_cms.license_url      = 'http://creativecommons.org/licenses/by-nc-sa/4.0/'
    end
  end
end
