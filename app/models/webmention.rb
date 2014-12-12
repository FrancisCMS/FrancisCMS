class Webmention < ActiveRecord::Base
  belongs_to :webmentionable, polymorphic: true
  has_one :webmention_entry

  validates :source, :target, presence: true
  validates :source, format: { :with => URI::regexp(%w(http https)) }
  validates :target, format: { :with => %r{\A#{Settings.site.url}/?} }

  delegate :author_name, :author_photo, :author_url,
           :entry_content, :entry_name, :entry_url,
           :published_at, to: :webmention_entry

  def add_webmention_entry(collection)
    WebmentionEntry.create_from_collection(self, collection)
  end

  def status_string
    verified_at? ? 'verified' : 'unverified'
  end

  def verify
    WebmentionVerification.new(self).verify
  end

  def self.verify_all
    where(verified_at: nil).each(&:verify)
  end
end
