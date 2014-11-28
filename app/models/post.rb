class Post < ActiveRecord::Base
  include Publishable

  validates :title, :slug, :body, presence: true
end
