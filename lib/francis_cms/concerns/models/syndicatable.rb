module FrancisCms::Concerns::Models::Syndicatable
  extend ActiveSupport::Concern

  included do
    has_many :syndications, as: :syndicatable, dependent: :destroy
  end

  def can_automatically_syndicate?
    can_syndicate_to_flickr?
  end

  def can_syndicate_to_flickr?
    self.is_photo? &&
    !Flickr.api_key.blank? &&
    !Flickr.shared_secret.blank? &&
    !Flickr.access_token_key.blank? &&
    !Flickr.access_token_secret.blank?
  end

  def is_photo?
    self.class.name.demodulize == 'Photo'
  end
end
