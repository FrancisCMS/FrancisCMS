Flickr.configure do |config|
  config.api_key             = Rails.application.secrets.flickr_api_key
  config.shared_secret       = Rails.application.secrets.flickr_shared_secret
  config.access_token_key    = Rails.application.secrets.flickr_access_token_key
  config.access_token_secret = Rails.application.secrets.flickr_access_token_secret
end
