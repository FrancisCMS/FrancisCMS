module FrancisCMS
  module Helpers
    module LinksHelper
      def link
        @link ||= Link.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        halt 404
      end

      # ----- URL Helpers ---------- #
      def links_path
        '/links'
      end

      def links_url
        base_url + links_path
      end

      def link_path(id)
        "#{links_path}/#{id}"
      end

      def link_url(id)
        base_url + link_path(id)
      end

      def new_link_path
        "#{links_path}/new"
      end

      def edit_link_path(id)
        "#{link_path(id)}/edit"
      end
    end
  end
end