class Webmention < ActiveRecord::Base
  belongs_to :webmentionable, polymorphic: true

  validates :source, :target, presence: true
  validates :source, format: { :with => URI::regexp(%w(http https)) }
  validates :target, format: { :with => %r{\A#{Settings.site.url}/?} }

  def author_name
    name = entry.try(:author).try(:format).try(:name)
    name ||= card.try(:name)
    name ||= URI.parse(source).host

    name.to_s
  end

  def author_photo
    photo = entry.try(:author).try(:format).try(:photo)
    photo ||= card.try(:photo)
    photo ||= 'http://www.placecage.com/150/150'

    absolutize photo.to_s
  end

  def author_url
    url_parts = URI.parse(source)

    url = entry.try(:author).try(:format).try(:url)
    url ||= card.try(:url)
    url ||= "#{url_parts.scheme}://#{url_parts.host}"

    absolutize url.to_s
  end

  def entry_content
    entry.content
  end

  def entry_name
    entry.name.to_s
  end

  def entry_url
    url = entry.try(:url)
    url ||= source

    absolutize url.to_s
  end

  def published_at
    date = entry.try(:published)
    date ||= created_at

    Time.parse(date.to_s)
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
      Microformats2::AbsoluteUri.new(source_domain, url)
    else
      url
    end
  end

  def card
    parsed_html.card
  end

  def entry
    parsed_html.entry
  end

  def parsed_html
    Microformats2.parse(html)
  end

  def source_domain
    @source_domain ||= URI.parse(source).select(:scheme, :host).join('://')
  end
end
