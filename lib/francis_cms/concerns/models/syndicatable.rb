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
            [
              :flicker_api_key,
              :flickr_shared_secret,
              :flickr_access_token_key,
              :flickr_access_token_secret
            ].map { |key| Rails.application.secrets[key].present? }.all?
        end

        def can_syndicate_to_medium?
          post? && Rails.application.secrets.medium_integration_token.present?
        end

        def can_syndicate_to_twitter?
          [
            :twitter_consumer_key,
            :twitter_consumer_secret,
            :twitter_access_token,
            :twitter_access_token_secret
          ].map { |key| Rails.application.secrets[key].present? }.all?
        end

        def link?
          instance_of?(FrancisCms::Link)
        end

        def photo?
          instance_of?(FrancisCms::Photo)
        end

        def post?
          instance_of?(FrancisCms::Post)
        end
      end
    end
  end
end
