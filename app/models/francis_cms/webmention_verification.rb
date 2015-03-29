module FrancisCms
  class WebmentionVerification
    delegate :source, :target, to: :@webmention

    def initialize(webmention)
      @webmention = webmention
      @agent = Mechanize.new
    end

    def verify
      @agent.user_agent = "#{FrancisCms.configuration.site_url}/ (http://webmention.org/)"

      if target_accepts_webmentions? && source_links_to_target?
        collection = Microformats2.parse(source_page.body)

        entry_properties = collection.try(:entry) ? collection.entry.to_hash[:properties] : {}

        @webmention.update_attributes(
          webmentionable: get_webmentionable,
          webmention_type: get_type(entry_properties),
          verified_at: Time.now
        )

        @webmention.add_webmention_entry(collection)
      else
        @webmention.delete
      end
    rescue Mechanize::ResponseCodeError => err
      case err.response_code
        when '404', '410'; @webmention.delete
      end
    rescue Mechanize::SocketError
    end

    private

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
      # Use canonical target URL to account for 301 redirects
      matches = target_page.uri.to_s.match(%r{\A#{FrancisCms.configuration.site_url}/(?<path>[a-z]+)/(?<params>[A-Za-z0-9\-]+)\Z})

      if matches
        begin
          klass = "FrancisCms::#{matches[:path].classify}".constantize

          # If klass includes Webmentionable concern
          if klass < FrancisCms::Concerns::Models::Webmentionable
            webmentionable = klass.find(matches[:params])
          end
        rescue
        end
      end

      webmentionable
    end

    def source_links_to_target?
      if URI.parse(source).host == URI.parse(target).host
        # If source and target are on the same domain, target should be relative
        regex = %r{#{target}|#{target.sub(FrancisCms.configuration.site_url + '/', '/')}}
      else
        # Check for links to target (with or without trailing slash)
        regex = %r{#{target}|#{target.sub(/.*\/+?$/, '')}}
      end

      source_page.link_with(href: regex).present?
    end

    def source_page
      @source_page ||= @agent.get(source)
    end

    def target_accepts_webmentions?
      if target_page.header.key? 'link'
        # Search for endpoint in Link header
        supported = target_page.header['link'].match(/<((?:https?:\/\/)?[^>]+)>; rel="(?:[^>]*\s+|\s*)(?:webmention|http:\/\/webmention.org\/?)(?:\s*|\s+[^>]*)"/i)
      else
        # Search for endpoint in <link> and <a> elements
        supported = target_page.search('link[rel~="webmention"]', 'link[rel~="http://webmention.org/"]', 'a[rel~="webmention"]', 'a[rel~="http://webmention.org/"]').first
      end

      supported
    end

    def target_page
      @target_page ||= @agent.get(target)
    end
  end
end
