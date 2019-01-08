module FrancisCms
  module Syndications
    class Flickr
      CLIENT_PARAMS = {
        api_key:             Rails.application.secrets.flickr_api_key,
        shared_secret:       Rails.application.secrets.flickr_shared_secret,
        access_token_key:    Rails.application.secrets.flickr_access_token_key,
        access_token_secret: Rails.application.secrets.flickr_access_token_secret
      }.freeze

      def initialize(syndicatable, canonical_url)
        @syndicatable = syndicatable
        @canonical_url = canonical_url

        @client = ::Flickr

        @client.configure do |config|
          CLIENT_PARAMS.each do |key, value|
            config.public_send("#{key}=", value)
          end
        end
      end

      def publish
        photo_id = @client.upload(@syndicatable.photo.path, options)
        username = @client.photos.find(photo_id).get_info!.owner.username

        {
          name: 'Flickr',
          url: "https://www.flickr.com/photos/#{username}/#{photo_id}/"
        }
      rescue => error
        Rails.logger.error "!!! Flickr syndication error: #{error.message}"
      end

      private

      def options
        {
          title: @syndicatable.title,
          description: "#{@syndicatable.to_html.lines.drop(1).join.chomp}\n\nOriginally published at #{@canonical_url}.",
          tags: @syndicatable.tags.collect { |tag| %("#{tag}") }.join(' ')
        }
      end
    end
  end
end
