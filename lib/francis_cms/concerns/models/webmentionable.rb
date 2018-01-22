module FrancisCms
  module Concerns
    module Models
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
          verified_webmentions.where(webmention_type: %w[reply reference])
        end

        private

        def verified_webmentions
          webmentions.joins(:webmention_entry).where('verified_at IS NOT NULL').order('francis_cms_webmention_entries.published_at ASC')
        end
      end
    end
  end
end
