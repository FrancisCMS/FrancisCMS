module FrancisCms
  class Webmention < ActiveRecord::Base
    belongs_to :webmentionable, polymorphic: true
    has_one :webmention_entry

    validates :source, :target, presence: true
    validates :source, format: { with: URI.regexp(%w[http https]) }
    validates :target, format: { with: /\A#{FrancisCms.configuration.site_url.sub(/^https?:/, 'https?:')}?/ }
    validates_with WebmentionValidator

    delegate :author_avatar, :author_avatar_url, :author_name, :author_photo_url,
             :author_url, :entry_content, :entry_name, :entry_url, :entry_url_host,
             :published_at, to: :webmention_entry

    self.per_page = 100

    def create_webmention_entry(collection)
      WebmentionEntry.create_from_collection(self, collection)
    end

    def destroy_webmention_entry
      webmention_entry.destroy
    end

    def status_string
      verified_at? ? 'verified' : 'unverified'
    end

    def verify
      WebmentionVerification.new(self).verify
    end

    def self.verify_all
      where(verified_at: nil).find_each(&:verify)
    end
  end
end
