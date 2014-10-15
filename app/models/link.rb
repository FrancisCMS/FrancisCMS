module FrancisCMS
  module Models
    class Link < ActiveRecord::Base
      include Publishable
      include Redcarpeted
      include Taggable

      validates :url, :title, presence: true

      redcarpet :body
    end
  end
end