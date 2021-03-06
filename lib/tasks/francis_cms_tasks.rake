require 'modules/conversable'

# rubocop:disable Rails/RakeEnvironment
namespace :francis_cms do
  desc 'Configure Flickr syndication'
  task :configure_flickr do
    include Conversable

    notify 'Preparing to configure Flickr syndication...'

    api_key = ask?('What\'s your Flickr API key?')
    shared_secret = ask?('What\'s your Flickr API shared secret?')

    Flickr.configure do |config|
      config.api_key = api_key
      config.shared_secret = shared_secret
    end

    # rubocop:disable Style/RescueStandardError
    begin
      request_token = Flickr::OAuth.get_request_token

      notify 'Open the following URL and click "OK, I\'ll authorize it"...'
      puts request_token.authorize_url

      verification_code = ask?('What\'s your verification code? (This is the code Flickr just gave you!)')

      access_token = request_token.get_access_token(verification_code)

      notify 'Success! Here\'s your Flickr syndication configuration. Copy and paste this into `config/secrets.yml`...'

      puts "flickr_api_key: #{api_key}"
      puts "flickr_shared_secret: #{shared_secret}"
      puts "flickr_access_token_key: #{access_token.key}"
      puts "flickr_access_token_secret: #{access_token.secret}"
    rescue
      alert '! Ack, there was a problem generating Flickr syndication configuration. Please try again.'
    end
    # rubocop:enable Style/RescueStandardError
  end
end
# rubocop:enable Rails/RakeEnvironment
