require 'rubygems'
require 'bundler'
require 'active_support/all'

Bundler.require
$: << File.expand_path('../', __FILE__)

Dir.glob('config/initializers/*.rb', &method(:require))
Dir.glob('app/*.rb', &method(:require))

module FrancisCMS
  class App < Sinatra::Application
    configure do
      set :root, File.dirname(__FILE__)
      set :views, Proc.new { File.join(root, 'app/views') }
    end

    use Rack::Deflater

    use Routes::Links
    use Routes::Main
    use Routes::Posts
    use Routes::Sessions
    use Routes::Tags
  end
end

include FrancisCMS::Concerns
include FrancisCMS::Models