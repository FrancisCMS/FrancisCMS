module FrancisCMS
  module Models
    class Post < ActiveRecord::Base
      include FriendlyId
      include Publishable
      include Redcarpeted
      include Taggable
      include Webmentionable

      validates :title, :slug, :body, presence: true

      friendly_id :title
      redcarpet :body

      def should_generate_new_friendly_id?
        slug? ? false : title_changed?
      end
    end
  end
end