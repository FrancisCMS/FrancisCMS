module FrancisCms::Concerns::Models::Syndicatable
  extend ActiveSupport::Concern

  included do
    has_many :syndications, as: :syndicatable, dependent: :destroy
  end

  def can_automatically_syndicate?
    can_syndicate_to_flickr? || can_syndicate_to_medium? || can_syndicate_to_twitter?
  end

  def can_syndicate_to_flickr?
    self.is_photo? &&
    !Rails.application.secrets.flickr_api_key.blank? &&
    !Rails.application.secrets.flickr_shared_secret.blank? &&
    !Rails.application.secrets.flickr_access_token_key.blank? &&
    !Rails.application.secrets.flickr_access_token_secret.blank?
  end

  def can_syndicate_to_medium?
    self.is_post? &&
    !Rails.application.secrets.medium_integration_token.blank?
  end

  def can_syndicate_to_twitter?
    !Rails.application.secrets.twitter_consumer_key.blank? &&
    !Rails.application.secrets.twitter_consumer_secret.blank? &&
    !Rails.application.secrets.twitter_access_token.blank? &&
    !Rails.application.secrets.twitter_access_token_secret.blank?
  end

  def is_link?
    self.class == FrancisCms::Link
  end

  def is_photo?
    self.class == FrancisCms::Photo
  end

  def is_post?
    self.class == FrancisCms::Post
  end
end
