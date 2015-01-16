module FrancisCms
  class Link < ActiveRecord::Base
    include FrancisCms::Concerns::Models::Publishable
    include FrancisCms::Concerns::Models::Redcarpeted
    include FrancisCms::Concerns::Models::Syndicatable
    include FrancisCms::Concerns::Models::Taggable
    include FrancisCms::Concerns::Models::Webmentionable

    validates :url, :title, presence: true

    redcarpet :body

    self.per_page = 20
  end
end
