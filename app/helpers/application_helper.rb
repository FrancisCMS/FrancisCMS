class FrancisCMS < Sinatra::Base
  helpers do
    def link_to(body, url, html_options = {})
      attributes = []

      html_options.each_pair do |key, value|
        attributes << %(#{key}="#{value}")
      end

      "<a href=\"#{url}\" #{attributes.sort * ' '}>#{body}</a>"
    end

    def root_path
      '/'
    end
  end
end