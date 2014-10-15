module FrancisCMS
  module Models
    class Tagging < ActiveRecord::Base
      belongs_to :tag
      belongs_to :taggable, polymorphic: true
    end
  end
end