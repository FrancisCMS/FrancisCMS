module FrancisCMS
  module Models
    class Webmention < ActiveRecord::Base
      belongs_to :webmentionable, polymorphic: true

      validates :source, :target, presence: true
      validates :source, format: { :with => URI::regexp(%w(http https)) }
      validates :target, format: { :with => %r{\A#{App.settings.site_url}/?} }

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

        date.to_s.to_datetime
      end

      def verify
        agent = Mechanize.new

        agent.user_agent = "#{App.settings.site_url}/ (http://webmention.org/)"

        source_page = agent.get(source)

        if target_accepts_webmentions?(agent.get(target)) && source_links_to_target?(source_page)
          collection = Microformats2.parse(source_page.body)
          entry_properties = collection.entry.to_hash[:properties]

          update_attributes(
            webmentionable: get_webmentionable,
            webmention_type: get_type(entry_properties),
            html: source_page.body,
            json: collection.to_json,
            verified_at: Time.now.utc
          )
        else
          delete
        end
      rescue ActiveRecord::RecordNotFound
        delete
      rescue Mechanize::ResponseCodeError => err
        case err.response_code
          when '404', '410'; delete
        end
      end

      def self.verify_all
        where(verified_at: nil).each(&:verify)
      end

      private

      def absolutize(url)
        if !url.match(%r{^https?://})
          url_parts = URI.parse(source)

          url = "#{url_parts.scheme}://#{url_parts.host}/#{url}"
        end

        url
      end

      def card
        parsed_html.card
      end

      def entry
        parsed_html.entry
      end

      def get_type(properties)
        if properties.has_key?(:like_of)
          'like'
        elsif properties.has_key?(:in_reply_to)
          'reply'
        elsif properties.has_key?(:repost_of)
          'repost'
        else
          'reference'
        end
      end

      def get_webmentionable
        matches = target.match(%r{\A#{App.settings.site_url}/?(?<path>[links|posts])?/?(?<params>[A-Za-z0-9\-]+)?$})

        if matches && matches[:path] && matches[:params]
          webmentionable = matches[:path].singularize.capitalize.constantize.find(matches[:params])
        end

        webmentionable ||= nil
      end

      def parsed_html
        Microformats2.parse(html)
      end

      def source_links_to_target?(page)
        if URI.parse(source).host == URI.parse(target).host
          # If source and target are on the same domain, target should be relative
          regex = %r{#{target}|#{target.sub(App.settings.site_url + '/', '/')}}
        else
          # Check for links to target (with or without trailing slash)
          regex = %r{#{target}|#{target.sub(/.*\/+?$/, '')}}
        end

        page.link_with(href: regex).present?
      end

      def target_accepts_webmentions?(page)
        if page.header.key? 'link'
          # Search for endpoint in Link header
          supported = page.header['link'].match(/<((?:https?:\/\/)?[^>]+)>; rel="(?:[^>]*\s+|\s*)(?:webmention|http:\/\/webmention.org\/?)(?:\s*|\s+[^>]*)"/i)
        else
          # Search for endpoint in <link> and <a> elements
          supported = page.search('link[rel~="webmention"]', 'link[rel~="http://webmention.org/"]', 'a[rel~="webmention"]', 'a[rel~="http://webmention.org/"]').first
        end

        supported
      end
    end
  end
end