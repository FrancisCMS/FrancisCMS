module FrancisCMS
  module Models
    class Post < ActiveRecord::Base
      include FriendlyId
      include Publishable
      include Redcarpeted
      include Syndicatable
      include Taggable
      include Webmentionable

      validates :title, :slug, :body, presence: true

      friendly_id :title
      redcarpet :body

      self.per_page = 10

      def should_generate_new_friendly_id?
        slug? ? false : title_changed?
      end
    end
  end
end