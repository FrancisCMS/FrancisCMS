module FrancisCMS
  module Models
    class Link < ActiveRecord::Base
      include Publishable
      include Redcarpeted
      include Syndicatable
      include Taggable
      include Webmentionable

      validates :url, :title, presence: true

      redcarpet :body
    end
  end
end