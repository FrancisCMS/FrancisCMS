class FrancisCMS < Sinatra::Base
  helpers do
    def base_url
      @base_url ||= request.base_url
    end

    def link_to(body, url, html_options = {})
      attrs = [%Q{href="#{url}"}]

      html_options.each_pair do |key, value|
        attrs << %Q{#{key}="#{value}"}
      end

      %Q{<a #{attrs.sort * ' '}>#{body}</a>}
    end

    def root_path
      '/'
    end
  end
end