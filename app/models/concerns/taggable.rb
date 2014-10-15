module FrancisCMS
  module Concerns
    module Taggable
      extend ActiveSupport::Concern

      included do
        attr_writer :tag_list

        has_many :taggings, as: :taggable, dependent: :destroy
        has_many :tags, through: :taggings

        def tag_list
          tags.map(&:name).join(', ')
        end
      end
    end
  end
end