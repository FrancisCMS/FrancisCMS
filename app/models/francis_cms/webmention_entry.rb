module FrancisCms
  class WebmentionEntry < ActiveRecord::Base
    belongs_to :webmention

    def entry_url_host
      URI.parse(entry_url).host.gsub(/^www\./, '')
    end

    def self.attributes_from_collection(webmention, collection)
      WebmentionEntry::AttributesBuilder.new(webmention, collection).attributes
    end

    def self.create_from_collection(webmention, collection)
      where(webmention: webmention).first_or_create(attributes_from_collection(webmention, collection))
    end

    class AttributesBuilder
      def initialize(webmention, collection)
        @webmention = webmention
        @source = webmention.source
        @collection = collection
      end

      def attributes
        {
          author_name: author_name,
          author_photo_url: author_photo_url,
          author_url: author_url,
          entry_content: entry_content,
          entry_name: entry_name,
          entry_url: entry_url,
          published_at: published_at,
          webmention: @webmention
        }
      end

      def author_name
        # Microformats2 returns Microformats2::Property::Text
        (author_name_from_entry || author_name_from_card || author_name_from_source_url).to_s
      end

      def author_photo_url
        # Microformats2 returns Microformats2::Property::Url
        absolutize (author_photo_url_from_entry || author_photo_url_from_card).to_s
      end

      def author_url
        # Microformats2 returns Microformats2::Property::Url
        absolutize (author_url_from_entry || author_url_from_card || author_url_from_source_url).to_s
      end

      def entry_content
        entry.try(:content).to_s
      end

      def entry_name
        (entry.try(:name) || entry_url.gsub(%r{^https?://(www.)?}, '')).to_s
      end

      def entry_url
        # Microformats2 returns Microformats2::Property::Url
        absolutize (entry_url_from_entry || @source).to_s
      end

      def published_at
        # Microformats2 returns Microformats2::Property::DateTime
        Time.parse (published_at_from_entry || @webmention.created_at).to_s
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
        URI.parse(@source).host
      end

      def author_photo_url_from_card
        card.try(:photo)
      end

      def author_photo_url_from_entry
        entry.try(:author).try(:format).try(:photo)
      end

      def author_url_from_card
        card.try(:url)
      end

      def author_url_from_entry
        entry.try(:author).try(:format).try(:url)
      end

      def author_url_from_source_url
        uri = URI.parse(@source)

        "#{uri.scheme}://#{uri.host}/"
      end

      def card
        @collection.try(:card)
      end

      def entry
        @collection.try(:entry)
      end

      def entry_url_from_entry
        entry.try(:url)
      end

      def published_at_from_entry
        entry.try(:published)
      end

      def source_domain
        @source_domain ||= URI.parse(@source).select(:scheme, :host).join('://')
      end
    end
  end
end
