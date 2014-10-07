require 'sinatra/base'
require 'sinatra/namespace'

class FrancisCMS < Sinatra::Base
  set :views, Proc.new { File.join(root, 'app/views') }

  register Sinatra::Namespace
end

Dir.glob('./app/**/*.rb', &method(:require))