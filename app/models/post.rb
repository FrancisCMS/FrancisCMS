module FrancisCMS
  module Models
    class Post < ActiveRecord::Base
      include Htmlable
      include FriendlyId
      include Publishable

      validates :title, :slug, :body, presence: true

      friendly_id :title

      def should_generate_new_friendly_id?
        slug? ? false : title_changed?
      end
    end
  end
end