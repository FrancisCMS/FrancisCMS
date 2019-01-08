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

        @client = ::Twitter::REST::Client.new(CLIENT_PARAMS)
      end

      def publish
        url = @syndicatable.link? ? @syndicatable.url : @canonical_url

        if @syndicatable.photo?
          status = @syndicatable.title.truncate(90, omission: '…', separator: ' ')
          tweet = @client.update_with_media("#{status} – #{url}", File.new(@syndicatable.photo.path), options)
        else
          status = @syndicatable.title.truncate(114, omission: '…', separator: ' ')
          tweet = @client.update("#{status} – #{url}", options)
        end

        {
          name: 'Twitter',
          url: "https://twitter.com/#{tweet.user.screen_name}/status/#{tweet.id}"
        }
      rescue => error
        Rails.logger.error "!!! Twitter syndication error: #{error.message}"
      end

      private

      def options
        {}.tap do |opts|
          if @syndicatable.try(:geolocated?)
            places = @client.reverse_geocode(lat: @syndicatable.latitude, long: @syndicatable.longitude)

            opts[:place] = places.first if places.any?
          end
        end
      end
    end
  end
end
