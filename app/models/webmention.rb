class Webmention < ActiveRecord::Base
  belongs_to :webmentionable, polymorphic: true

  validates :source, :target, presence: true
  validates :source, format: { :with => URI::regexp(%w(http https)) }
  validates :target, format: { :with => %r{\A#{Settings.site.url}/?} }

  def author_name
    # Microformats2 returns Microformats2::Property::Text
    (author_name_from_entry || author_name_from_card || author_name_from_source_url).to_s
  end

  def author_photo
    # Microformats2 returns Microformats2::Property::Url
    absolutize (author_photo_from_entry || author_photo_from_card || 'http://www.placecage.com/150/150').to_s
  end

  def author_url
    # Microformats2 returns Microformats2::Property::Url
    absolutize (author_url_from_entry || author_url_from_card || author_url_from_source_url).to_s
  end

  def entry_content
    entry.content
  end

  def entry_name
    entry.name.to_s
  end

  def entry_url
    # Microformats2 returns Microformats2::Property::Url
    absolutize (entry_url_from_entry || source).to_s
  end

  def published_at
    # Microformats2 returns Microformats2::Property::DateTime
    Time.parse (published_at_from_entry || created_at).to_s
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

  private

  def absolutize(url)
    if !URI.parse(url).scheme
      Microformats2::AbsoluteUri.new(source_domain, url).absolutize
    else
      url
    end
  end

  def author_name_from_card
    card.try(:name)
  end

  def author_name_from_entry
    entry.try(:author).try(:format).try(:name)
  end

  def author_name_from_source_url
    URI.parse(source).host
  end

  def author_photo_from_card
    card.try(:photo)
  end

  def author_photo_from_entry
    entry.try(:author).try(:format).try(:photo)
  end

  def author_url_from_card
    card.try(:url)
  end

  def author_url_from_entry
    entry.try(:author).try(:format).try(:url)
  end

  def author_url_from_source_url
    uri = URI.parse(source)

    "#{uri.scheme}://#{uri.host}/"
  end

  def card
    parsed_html.card
  end

  def entry
    parsed_html.entry
  end

  def entry_url_from_entry
    entry.try(:url)
  end

  def parsed_html
    Microformats2.parse(html)
  end

  def published_at_from_entry
    entry.try(:published)
  end

  def source_domain
    @source_domain ||= URI.parse(source).select(:scheme, :host).join('://')
  end
end
