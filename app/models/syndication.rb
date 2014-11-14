module FrancisCMS
  module Models
    class Syndication < ActiveRecord::Base
      belongs_to :syndicatable, polymorphic: true

      validates :url, :name, presence: true
      validates :url, uniqueness: true

      default_scope { order('name ASC') }
    end
  end
end