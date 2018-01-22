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
      %(<iframe src="#{embed_url}" allowfullscreen title="#{embed_title}"></iframe>)
    end

    private

    def embed_title
      return 'Vimeo video player' if vimeo?
      return 'YouTube video player' if youtube?
    end

    def embed_url
      return %(https://player.vimeo.com/video/#{parsed_url.path.tr('/', '')}) if vimeo?
      return %(https://www.youtube.com/embed/#{CGI.parse(parsed_url.query)['v'][0]}) if youtube?
    end

    def vimeo?
      parsed_url.host.gsub(/^www\./, '').match(/^vimeo\.com/)
    end

    def youtube?
      parsed_url.host.gsub(/^www\./, '').match(/^youtube\.com/)
    end

    def parsed_url
      @parsed_url ||= URI.parse(url)
    end
  end
end
