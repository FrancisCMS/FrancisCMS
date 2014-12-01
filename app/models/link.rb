class Link < ActiveRecord::Base
  include Publishable
  include Redcarpeted
  include Syndicatable
  include Taggable
  include Webmentionable

  validates :url, :title, presence: true

  redcarpet :body

  self.per_page = 20
end
