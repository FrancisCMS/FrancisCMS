module FrancisCMS
  module Models
    class Tag < ActiveRecord::Base
      include FriendlyId

      has_many :taggings
      has_many :links, through: :taggings, source: :taggable, source_type: Link
      has_many :posts, through: :taggings, source: :taggable, source_type: Post

      validates :name, :slug, presence: true

      friendly_id :name

      def self.destroy_unused
        joins('LEFT OUTER JOIN taggings ON taggings.tag_id = tags.id').where('tag_id IS NULL').destroy_all
      end
    end
  end
end