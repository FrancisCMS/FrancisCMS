module FrancisCms
  class Post < ActiveRecord::Base
    extend FriendlyId
    include FrancisCms::Concerns::Models::Publishable
    include FrancisCms::Concerns::Models::Redcarpeted
    include FrancisCms::Concerns::Models::Syndicatable
    include FrancisCms::Concerns::Models::Taggable
    include FrancisCms::Concerns::Models::Webmentionable

    validates :title, :slug, :body, presence: true

    friendly_id :title
    redcarpet :body

    self.per_page = 10
  end
end
