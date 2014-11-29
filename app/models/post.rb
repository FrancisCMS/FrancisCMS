class Post < ActiveRecord::Base
  extend FriendlyId
  include Publishable
  include Redcarpeted

  validates :title, :slug, :body, presence: true

  friendly_id :title
  redcarpet :body

  self.per_page = 10
end
