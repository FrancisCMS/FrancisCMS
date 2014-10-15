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

      def link_path(id)
        File.join links_path, id.to_s
      end

      def new_link_path
        File.join links_path, 'new'
      end

      def edit_link_path(id)
        File.join link_path(id), 'edit'
      end
    end
  end
end