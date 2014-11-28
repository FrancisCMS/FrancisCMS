class Post < ActiveRecord::Base
  include Publishable
  include Redcarpeted

  validates :title, :slug, :body, presence: true

  redcarpet :body
end
