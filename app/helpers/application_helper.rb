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

      def image_tag(source, html_options = {})
        attrs = [%Q{src="#{source}"}]

        html_options.each_pair do |key, value|
          attrs << %Q{#{key}="#{value}"}
        end

        "<img #{attrs.sort * ' '}>"
      end

      def link_to(body, url, html_options = {})
        attrs = [%Q{href="#{url}"}]

        html_options.each_pair do |key, value|
          attrs << %Q{#{key}="#{value}"}
        end

        "<a #{attrs.sort * ' '}>#{body}</a>"
      end

      def logged_in?
        return !!session[:user_id]
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

      def require_login
        redirect login_path unless logged_in?
      end
    end
  end
end