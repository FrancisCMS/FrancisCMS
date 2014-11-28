class Link < ActiveRecord::Base
  include Publishable

  validates :url, :title, presence: true
end
