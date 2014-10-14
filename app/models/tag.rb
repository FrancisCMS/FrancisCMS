module FrancisCMS
  module Models
    class Tag < ActiveRecord::Base
      include FriendlyId

      has_many :taggings
      has_many :links, through: :taggings, source: :taggable, source_type: Link
      has_many :posts, through: :taggings, source: :taggable, source_type: Post

      validates :name, :slug, presence: true

      friendly_id :name
    end
  end
end