module FrancisCMS
  module Models
    class Post < ActiveRecord::Base
      include HTMLable
      include FriendlyId

      acts_as_ordered_taggable

      validates :title, :slug, :body, presence: true

      friendly_id :title, use: :slugged

      def self.recent_posts_for_feed
        limit(10).order('published_at DESC')
      end
    end
  end
end