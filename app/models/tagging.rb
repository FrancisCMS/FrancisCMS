module FrancisCMS
  module Models
    class Tagging < ActiveRecord::Base
      attr_accessor :tag_id, :taggable_id, :taggable_type

      belongs_to :tag
      belongs_to :taggable, polymorphic: true
    end
  end
end