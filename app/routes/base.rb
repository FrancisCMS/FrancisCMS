module FrancisCMS
  module Routes
    class Base < Sinatra::Application
      configure do
        set :root, App.settings.root
        set :views, App.settings.views

        set :erb, escape_html: true
        set :partial_template_engine, :erb
        set :partial_underscores, true

        enable :method_override
        enable :sessions
      end

      config_file 'config/settings.yml'

      helpers Helpers::ApplicationHelper
      helpers Helpers::FeedsHelper
      helpers Helpers::LinksHelper
      helpers Helpers::PostsHelper
      helpers Helpers::SessionsHelper
      helpers Helpers::TagsHelper
    end
  end
end