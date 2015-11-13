module FrancisCms
  class Photo < ActiveRecord::Base
    include FrancisCms::Concerns::Models::Publishable
    include FrancisCms::Concerns::Models::Redcarpeted
    include FrancisCms::Concerns::Models::Syndicatable
    include FrancisCms::Concerns::Models::Taggable
    include FrancisCms::Concerns::Models::Webmentionable

    validates :photo, presence: true

    mount_uploader :photo, PhotoUploader

    redcarpet :body

    self.per_page = 20

    def title
      if body?
        body.lines.first.chomp
      else
        'Untitled'
      end
    end
  end
end
