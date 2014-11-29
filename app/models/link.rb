class Link < ActiveRecord::Base
  include Publishable
  include Redcarpeted
  include Taggable

  validates :url, :title, presence: true

  redcarpet :body

  self.per_page = 20
end
