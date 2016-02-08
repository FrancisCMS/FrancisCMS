Flickr.configure do |config|
  config.api_key             = Rails.application.secrets.flickr['api_key']
  config.shared_secret       = Rails.application.secrets.flickr['shared_secret']
  config.access_token_key    = Rails.application.secrets.flickr['access_token_key']
  config.access_token_secret = Rails.application.secrets.flickr['access_token_secret']
end
