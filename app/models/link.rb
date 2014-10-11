module FrancisCMS
  module Models
    class Link < ActiveRecord::Base
      include HTMLable

      acts_as_ordered_taggable

      validates :url, :title, presence: true

      def self.recent_links_for_feed
        limit(10).order('published_at DESC')
      end
    end
  end
end