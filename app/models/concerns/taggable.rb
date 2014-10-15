module FrancisCMS
  module Concerns
    module Taggable
      extend ActiveSupport::Concern

      included do
        attr_writer :tag_list

        has_many :taggings, as: :taggable, dependent: :destroy
        has_many :tags, through: :taggings

        after_update :notify_tag_of_update

        def tag_list
          tags.map(&:name).join(', ')
        end

        private

        def notify_tag_of_update
          Tag.destroy_unused
        end
      end
    end
  end
end