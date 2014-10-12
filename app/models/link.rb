module FrancisCMS
  module Models
    class Link < ActiveRecord::Base
      include Htmlable
      include Publishable

      validates :url, :title, presence: true
    end
  end
end