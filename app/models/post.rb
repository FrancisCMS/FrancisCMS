class Post < ActiveRecord::Base
  validates :title, :slug, :body, presence: true
end
