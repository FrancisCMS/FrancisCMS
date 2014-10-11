module FrancisCMS
  module Helpers
    module ApplicationHelper
      def alternate_link_tag(url, html_options = {})
        attrs = [%Q{href="#{url}"}, 'rel="alternate"']

        html_options.each_pair do |key, value|
          attrs << %Q{#{key}="#{value}"}
        end

        unless html_options.has_key? :type
          attrs << 'type="application/rss+xml"'
        end

        "<link #{attrs.sort * ' '}>"
      end

      def link_to(body, url, html_options = {})
        attrs = [%Q{href="#{url}"}]

        html_options.each_pair do |key, value|
          attrs << %Q{#{key}="#{value}"}
        end

        "<a #{attrs.sort * ' '}>#{body}</a>"
      end

      def page_description
        @page_description || settings.site['description']
      end

      def page_title
        if @page_title
          "#{@page_title} — #{settings.site['title']}"
        else
          "#{settings.site['title']} — #{settings.site['description']}"
        end
      end

      # ----- URL Helpers ---------- #
      def base_url
        @base_url ||= request.base_url
      end

      def root_path
        '/'
      end

      def url_for(path)
        base_url + path
      end
    end
  end
end