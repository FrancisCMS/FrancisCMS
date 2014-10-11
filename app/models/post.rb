module FrancisCMS
  module Models
    class Post < ActiveRecord::Base
      include HTMLable
      include Feedable
      include FriendlyId

      acts_as_ordered_taggable

      validates :title, :slug, :body, presence: true

      friendly_id :title, use: :slugged
    end
  end
end