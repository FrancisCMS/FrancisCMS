module FrancisCms
  class Link < ActiveRecord::Base
    include FrancisCms::Concerns::Models::Publishable
    include FrancisCms::Concerns::Models::Redcarpeted
    include FrancisCms::Concerns::Models::Syndicatable
    include FrancisCms::Concerns::Models::Taggable
    include FrancisCms::Concerns::Models::Webmentionable

    validates :url, :title, presence: true

    redcarpet :body

    self.per_page = 20

    def embeddable?
      embed_host[0] == 'vimeo.com' || (embed_host[0] == 'youtube.com' && parsed_url.query)
    end

    def embed_code
      %{<iframe src="#{embed_url}" allowfullscreen></iframe>}
    end

    private

    def embed_host
      @embed_host ||= parsed_url.host.gsub(/^www\./, '').match(%r{^(?:vimeo|youtube)\.com})
    end

    def embed_url
      if embed_host[0] == 'vimeo.com'
        %{https://player.vimeo.com/video/#{parsed_url.path.gsub('/', '')}}
      else
        %{https://www.youtube.com/embed/#{CGI::parse(parsed_url.query)['v'][0]}}
      end
    end

    def parsed_url
      @parsed_url ||= URI.parse(url)
    end
  end
end
