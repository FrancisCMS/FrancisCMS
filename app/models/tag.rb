module FrancisCMS
  module Models
    class Tag < ActiveRecord::Base
      include FriendlyId

      validates :name, :slug, presence: true

      friendly_id :name, use: :slugged
    end
  end
end