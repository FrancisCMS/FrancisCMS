class Link < ActiveRecord::Base
  include Publishable
  include Redcarpeted

  validates :url, :title, presence: true

  redcarpet :body
end
