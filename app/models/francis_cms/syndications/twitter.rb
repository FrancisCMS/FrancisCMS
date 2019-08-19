module FrancisCms
  module Syndications
    class Twitter
      CLIENT_PARAMS = {
        consumer_key:        Rails.application.secrets.twitter_consumer_key,
        consumer_secret:     Rails.application.secrets.twitter_consumer_secret,
        access_token:        Rails.application.secrets.twitter_access_token,
        access_token_secret: Rails.application.secrets.twitter_access_token_secret
      }.freeze

      def initialize(syndicatable, canonical_url)
        @syndicatable = syndicatable
        @canonical_url = canonical_url
      end

      # rubocop:disable Style/RescueStandardError
      def publish
        {
          name: 'Twitter',
          url:  "https://twitter.com/#{tweet.user.screen_name}/status/#{tweet.id}"
        }
      rescue => error
        Rails.logger.error "!!! Twitter syndication error: #{error.message}"
      end
      # rubocop:enable Style/RescueStandardError

      private

      attr_reader :canonical_url, :syndicatable

      def client
        @client ||= ::Twitter::REST::Client.new(CLIENT_PARAMS)
      end

      def options
        {}.tap do |opts|
          if syndicatable.try(:geolocated?)
            places = client.reverse_geocode(lat: syndicatable.latitude, long: syndicatable.longitude)

            opts[:place] = places.first if places.any?
          end
        end
      end

      def tweet
        @tweet ||= if syndicatable.photo?
                     client.update_with_media(tweet_body, File.new(syndicatable.photo.path), options)
                   else
                     client.update(tweet_body, options)
                   end
      end

      def tweet_body
        @tweet_body ||= "#{tweet_status} – #{syndicatable.link? ? syndicatable.url : canonical_url}"
      end

      def tweet_status
        @tweet_status ||= syndicatable.title.truncate(syndicatable.photo? ? 90 : 114, omission: '…', separator: ' ')
      end
    end
  end
end
