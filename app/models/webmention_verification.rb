class WebmentionVerification
  def initialize(webmention)
    @webmention = webmention
  end

  delegate :source, :target, to: :@webmention

  def verify
    agent = Mechanize.new

    agent.user_agent = "#{Settings.site.url}/ (http://webmention.org/)"

    source_page = agent.get(source)

    if target_accepts_webmentions?(agent.get(target)) && source_links_to_target?(source_page)
      collection = Microformats2.parse(source_page.body)
      entry_properties = collection.entry.to_hash[:properties]

      @webmention.update_attributes(
        webmentionable: get_webmentionable,
        webmention_type: get_type(entry_properties),
        html: source_page.body,
        json: collection.to_json,
        verified_at: Time.now
      )
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
    matches = target.match(%r{\A#{Settings.site.url}/(?<path>[a-z]+)/(?<params>[A-Za-z0-9\-]+)\Z})

    if matches
      begin
        klass = matches[:path].classify.constantize

        # If klass includes Webmentionable concern
        if klass < Webmentionable
          webmentionable = klass.find(matches[:params])
        end
      rescue
      end
    end

    webmentionable
  end

  def source_links_to_target?(page)
    if URI.parse(source).host == URI.parse(target).host
      # If source and target are on the same domain, target should be relative
      regex = %r{#{target}|#{target.sub(Settings.site.url + '/', '/')}}
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