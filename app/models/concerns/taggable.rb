module FrancisCMS
  module Concerns
    module Taggable
      extend ActiveSupport::Concern

      included do
        has_many :taggings, as: :taggable, dependent: :destroy
        has_many :tags, through: :taggings
      end
    end
  end
end