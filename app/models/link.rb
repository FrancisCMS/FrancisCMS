module FrancisCMS
  module Models
    class Link < ActiveRecord::Base
      include Feedable
      include Htmlable
      include Publishable

      acts_as_ordered_taggable

      validates :url, :title, presence: true
    end
  end
end