module FrancisCms
  class WebmentionVerification
    delegate :source, :target, to: :@webmention

    def initialize(webmention)
      @webmention = webmention

      agent.user_agent = "#{FrancisCms.configuration.site_url} (http://webmention.org/)"
    end

    def verify
      return create_webmention_entry if target_accepts_webmentions? && source_links_to_target?

      destroy_webmention_entry
    rescue Mechanize::ResponseCodeError => error
      case error.response_code
      when '404', '410'
        # @webmention.delete
        Rails.logger.error "!!! Webmention ##{@webmention.id} verification error: #{error.message}"
      end
    rescue Mechanize::SocketError => error
      Rails.logger.error "!!! Webmention ##{@webmention.id} verification error: #{error.message}"
    end

    private

    def agent
      @agent ||= Mechanize.new
    end

    def collection
      @collection ||= Microformats2.parse(source_page.body)
    end

    def create_webmention_entry
      @webmention.update(
        webmentionable:  webmentionable,
        webmention_type: webmention_type(entry_properties),
        fragmention:     fragmention,
        verified_at:     Time.now
      )

      @webmention.create_webmention_entry(collection)
    end

    def destroy_webmention_entry
      @webmention.update(
        webmentionable:  nil,
        webmention_type: nil,
        verified_at:     nil
      )

      @webmention.destroy_webmention_entry if @webmention.webmention_entry
    end

    def entry_properties
      @entry_properties ||= collection.try(:entry) ? collection.entry.to_hash[:properties] : {}
    end

    def fragment
      @fragment ||= target_page.uri.fragment
    end

    def fragmention
      CGI.unescape(fragment) if fragment
    end

    def regex_string
      # If source matches configured site URL (protocol-agnostic), target could be relative
      return target.sub(/^#{site_url_regex_string}/, %{(?:#{site_url_regex_string.chomp('/')})?/}) if source.match?(/^#{site_url_regex_string}/)

      # Check source for link to target (protocol-agnostic)
      target.sub(/^https?:/, 'https?:')
    end

    def site_url_regex_string
      @site_url_regex_string ||= FrancisCms.configuration.site_url.sub(/^https?:/, 'https?:')
    end

    def source_links_to_target?
      # Account for blank spaces in target URLs stored in database
      target.gsub!(' ', '%20')

      source_page.link_with(href: %r{^#{regex_string.chomp('/')}/?$}).present?
    end

    def source_page
      @source_page ||= agent.get(source)
    end

    def target_accepts_webmentions?
      # Search for endpoint in Link header
      return target_page.header['link'].match(%r{<((?:https?://)?[^>]+)>; rel="(?:[^>]*\s+|\s*)(?:webmention|http://webmention.org/?)(?:\s*|\s+[^>]*)"}i) if target_page.header.key?('link')

      # Search for endpoint in <link> and <a> elements
      target_page.search('link[rel~="webmention"]', 'link[rel~="http://webmention.org/"]', 'a[rel~="webmention"]', 'a[rel~="http://webmention.org/"]').first
    end

    def target_page
      @target_page ||= agent.get(target)
    end

    def webmention_type(properties)
      return 'like' if properties.key?(:like_of)
      return 'reply' if properties.key?(:in_reply_to)
      return 'repost' if properties.key?(:repost_of)

      'reference'
    end

    # rubocop:disable Style/RescueStandardError
    def webmentionable
      # Use canonical target URL to account for 301 redirects
      matches = target_page.uri.path.match(%r{(?<klass>[a-z]+)/(?<params>[A-Za-z0-9\-/]+)})

      if matches
        begin
          klass = "FrancisCms::#{matches[:klass].classify}".constantize

          # If klass includes Webmentionable concern
          webmentionable = klass.find(matches[:params]) if klass < FrancisCms::Concerns::Models::Webmentionable
        rescue => error
          Rails.logger.error "Webmentionable error: #{error.message}"
        end
      end

      webmentionable
    end
    # rubocop:enable Style/RescueStandardError
  end
end
