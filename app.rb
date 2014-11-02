require 'rubygems'
require 'bundler'

Bundler.require
$: << File.expand_path('../', __FILE__)

Dir.glob('config/initializers/*.rb', &method(:require))
Dir.glob('app/*.rb', &method(:require))

module FrancisCMS
  class App < Sinatra::Application
    configure do
      set :root, File.dirname(__FILE__)
      set :views, Proc.new { File.join(root, 'app/views') }

      set :site_url, YAML.load_file('config/settings.yml')['site']['url']
    end

    use Rack::Deflater

    use Routes::Feeds
    use Routes::Links
    use Routes::Posts
    use Routes::Root
    use Routes::Sessions
    use Routes::Tags
    use Routes::Webmentions
  end
end

include FrancisCMS::Concerns
include FrancisCMS::Models