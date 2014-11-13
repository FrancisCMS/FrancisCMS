module FrancisCMS
  module Routes
    class Base < Sinatra::Application
      configure do
        set :root, App.settings.root
        set :views, App.settings.views

        set :assets_css_compressor, :sass
        set :assets_precompile, %w(application.css)
        set :assets_prefix, %w(app/assets)

        set :erb, escape_html: true
        set :partial_template_engine, :erb
        set :partial_underscores, true

        enable :method_override
        enable :sessions
      end

      config_file 'config/settings.yml'

      helpers Helpers::ApplicationHelper
      helpers Helpers::FeedsHelper
      helpers Helpers::RoutesHelper

      register Sinatra::AssetPipeline

      RailsAssets.load_paths.each do |path|
        settings.sprockets.append_path(path)
      end
    end
  end
end