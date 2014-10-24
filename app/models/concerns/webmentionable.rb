module FrancisCMS
  module Concerns
    module Webmentionable
      extend ActiveSupport::Concern

      included do
        has_many :webmentions, as: :webmentionable, dependent: :destroy
      end

      def likes
        verified_webmentions.where(webmention_type: 'like')
      end

      def reposts
        verified_webmentions.where(webmention_type: 'repost')
      end

      def responses
        verified_webmentions.where(webmention_type: ['reply', 'reference'])
      end

      private

      def verified_webmentions
        webmentions.where('verified_at IS NOT NULL').order('created_at ASC')
      end
    end
  end
end