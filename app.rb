require 'active_support/all'
require 'sinatra/activerecord'
require 'sinatra/base'
require 'sinatra/config_file'
require 'sinatra/content_for'
require 'sinatra/namespace'
require 'sinatra/partial'
require 'acts-as-taggable-on'
require 'friendly_id'
require 'mechanize'
require 'redcarpet'

Dir.glob('./config/initializers/*.rb', &method(:require))

class FrancisCMS < Sinatra::Base
  I18n.enforce_available_locales = false

  helpers Sinatra::ContentFor

  register Sinatra::ConfigFile
  register Sinatra::Namespace
  register Sinatra::Partial

  config_file 'config/settings.yml'

  set :method_override, true
  set :partial_template_engine, :erb
  set :partial_underscores, true
  set :sessions, true
  set :views, Proc.new { File.join(root, 'app/views') }
end

Dir.glob('./app/**/*.rb', &method(:require))