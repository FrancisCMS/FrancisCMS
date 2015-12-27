module FrancisCms
  class Engine < ::Rails::Engine
    isolate_namespace FrancisCms

    config.autoload_paths << File.expand_path('../../', __FILE__)

    config.before_initialize do
      ActiveSupport.on_load :action_controller do
        helper FrancisCms::Engine.helpers
      end
    end

    config.before_configuration do |app|
      app.config.francis_cms = ActiveSupport::OrderedOptions.new

      app.config.francis_cms.logged_in_method = :logged_in?
      app.config.francis_cms.login_path       = '/login' # path may be relative or absolute

      app.config.francis_cms.site_url         = 'http://example.com/' # `site_url` must include protocol and trailing slash
      app.config.francis_cms.site_title       = 'FrancisCMS Demo Site'
      app.config.francis_cms.site_description = 'This is the default site description for a new FrancisCMS-powered website.'
      app.config.francis_cms.site_language    = 'en-US'

      app.config.francis_cms.user_name        = 'Jane Doe'
      app.config.francis_cms.user_email       = 'jane@example.com'
      app.config.francis_cms.user_avatar      = 'http://www.placecage.com/180/180' # path may be relative or absolute

      app.config.francis_cms.license_title    = 'Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International'
      app.config.francis_cms.license_url      = 'http://creativecommons.org/licenses/by-nc-sa/4.0/'
    end

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths['db/migrate'].expanded.each do |expanded_path|
          app.config.paths['db/migrate'] << expanded_path
        end
      end
    end
  end
end
