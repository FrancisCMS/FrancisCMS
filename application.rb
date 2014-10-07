require 'active_support/all'
require 'sinatra/activerecord'
require 'sinatra/base'
require 'sinatra/namespace'
require 'sinatra/partial'
require 'friendly_id'
require 'redcarpet'

Dir.glob('./config/initializers/*.rb', &method(:require))

class FrancisCMS < Sinatra::Base
  I18n.enforce_available_locales = false

  register Sinatra::Namespace
  register Sinatra::Partial

  set :views, Proc.new { File.join(root, 'app/views') }

  enable :partial_underscores
  set :partial_template_engine, :erb
end

Dir.glob('./app/**/*.rb', &method(:require))