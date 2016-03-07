module FrancisCms
  class WebmentionVerification
    delegate :source, :target, to: :@webmention

    def initialize(webmention)
      @webmention = webmention
      @agent = Mechanize.new
    end

    def verify
      @agent.user_agent = "#{FrancisCms.configuration.site_url} (http://webmention.org/)"

      if target_accepts_webmentions? && source_links_to_target?
        collection = Microformats2.parse(source_page.body)

        entry_properties = collection.try(:entry) ? collection.entry.to_hash[:properties] : {}

        @webmention.update_attributes(
          webmentionable: get_webmentionable,
          webmention_type: get_type(entry_properties),
          fragmention: get_fragmention,
          verified_at: Time.now
        )

        @webmention.create_webmention_entry(collection)
      else
        @webmention.update_attributes(
          webmentionable: nil,
          webmention_type: nil,
          verified_at: nil
        )

        if @webmention.webmention_entry
          @webmention.destroy_webmention_entry
        end
      end
    rescue Mechanize::ResponseCodeError => err
      case err.response_code
        when '404', '410'
          # @webmention.delete
      end
    rescue Mechanize::SocketError
    end

    private

    def get_fragmention
      fragment = target_page.uri.fragment

      if fragment
        URI.decode(fragment)
      end
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
      # Use canonical target URL to account for 301 redirects
      matches = target_page.uri.path.match(%r{(?<klass>[a-z]+)/(?<params>[A-Za-z0-9\-/]+)})

      if matches
        begin
          klass = "FrancisCms::#{matches[:klass].classify}".constantize

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
      # Account for blank spaces in target URLs stored in database
      target.gsub!(' ', '%20')

      site_url_regex_string = FrancisCms.configuration.site_url.sub(/^https?:/, 'https?:')

      if source.match(%r{^#{site_url_regex_string}})
        # If source matches configured site URL (protocol-agnostic), target could be relative
        regex_string = target.sub(/^#{site_url_regex_string}/, %{(?:#{site_url_regex_string.chomp('/')})?/})
      else
        # Check source for link to target (protocol-agnostic)
        regex_string = target.sub(/^https?:/, 'https?:')
      end

      source_page.link_with(href: %r{^#{regex_string.chomp('/')}/?$}).present?
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
