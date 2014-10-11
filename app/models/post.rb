module FrancisCMS
  module Models
    class Post < ActiveRecord::Base
      include HTMLable
      include FriendlyId

      acts_as_ordered_taggable

      validates :title, :slug, :body, presence: true

      friendly_id :title, use: :slugged

      def excerpt?
        excerpt.present?
      end
    end
  end
end