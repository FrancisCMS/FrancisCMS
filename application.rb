require 'active_support/all'
require 'sinatra/activerecord'
require 'sinatra/base'
require 'sinatra/namespace'
require 'friendly_id'
require 'redcarpet'

Dir.glob('./config/initializers/*.rb', &method(:require))

class FrancisCMS < Sinatra::Base
  set :views, Proc.new { File.join(root, 'app/views') }

  register Sinatra::Namespace
end

Dir.glob('./app/**/*.rb', &method(:require))