module FrancisCms
  module Concerns
    module Models
      module Syndicatable
        extend ActiveSupport::Concern

        included do
          has_many :syndications, as: :syndicatable, dependent: :destroy
        end

        def can_automatically_syndicate?
          can_syndicate_to_flickr? || can_syndicate_to_medium? || can_syndicate_to_twitter?
        end

        def can_syndicate_to_flickr?
          photo? &&
            Rails.application.secrets.flickr_api_key.present? &&
            Rails.application.secrets.flickr_shared_secret.present? &&
            Rails.application.secrets.flickr_access_token_key.present? &&
            Rails.application.secrets.flickr_access_token_secret.present?
        end

        def can_syndicate_to_medium?
          post? &&
            Rails.application.secrets.medium_integration_token.present?
        end

        def can_syndicate_to_twitter?
          Rails.application.secrets.twitter_consumer_key.present? &&
            Rails.application.secrets.twitter_consumer_secret.present? &&
            Rails.application.secrets.twitter_access_token.present? &&
            Rails.application.secrets.twitter_access_token_secret.present?
        end

        def link?
          self.class == FrancisCms::Link
        end

        def photo?
          self.class == FrancisCms::Photo
        end

        def post?
          self.class == FrancisCms::Post
        end
      end
    end
  end
end
