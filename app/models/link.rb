class Link < ActiveRecord::Base
  include HTMLable

  acts_as_ordered_taggable

  validates :url, :title, presence: true

  def body?
    body.present?
  end
end