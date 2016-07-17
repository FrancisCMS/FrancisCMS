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
    !Flickr.api_key.blank? &&
    !Flickr.shared_secret.blank? &&
    !Flickr.access_token_key.blank? &&
    !Flickr.access_token_secret.blank?
  end

  def can_syndicate_to_medium?
    self.is_post? &&
    !Rails.application.secrets.medium_integration_token.blank?
  end

  def can_syndicate_to_twitter?
    !TwitterClient.consumer_key.blank? &&
    !TwitterClient.consumer_secret.blank? &&
    !TwitterClient.access_token.blank? &&
    !TwitterClient.access_token_secret.blank?
  end

  def is_link?
    self.class.name.demodulize == 'Link'
  end

  def is_photo?
    self.class.name.demodulize == 'Photo'
  end

  def is_post?
    self.class.name.demodulize == 'Post'
  end
end
