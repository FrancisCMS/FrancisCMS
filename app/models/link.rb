class Link < ActiveRecord::Base
  include HTMLable

  validates :url, :title, presence: true

  def body?
    body.present?
  end
end