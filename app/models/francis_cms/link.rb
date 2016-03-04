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
      vimeo? || (youtube? && parsed_url.query)
    end

    def embed_code
      %{<iframe src="#{embed_url}" allowfullscreen></iframe>}
    end

    private

    def embed_url
      if vimeo?
        %{https://player.vimeo.com/video/#{parsed_url.path.gsub('/', '')}}
      elsif youtube?
        %{https://www.youtube.com/embed/#{CGI::parse(parsed_url.query)['v'][0]}}
      end
    end

    def vimeo?
      parsed_url.host.gsub(/^www\./, '').match(%r{^vimeo\.com})
    end

    def youtube?
      parsed_url.host.gsub(/^www\./, '').match(%r{^youtube\.com})
    end

    def parsed_url
      @parsed_url ||= URI.parse(url)
    end
  end
end
