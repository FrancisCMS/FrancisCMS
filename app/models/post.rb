class Post < ActiveRecord::Base
  include HTMLable
  include FriendlyId

  validates :title, :slug, :body, presence: true

  friendly_id :title, use: :slugged

  def excerpt?
    excerpt.present?
  end
end