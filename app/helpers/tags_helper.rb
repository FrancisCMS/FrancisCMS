module FrancisCMS
  module Helpers
    module TagsHelper
      def tag
        @tag ||= Tag.find(params[:slug])
      rescue ActiveRecord::RecordNotFound
        halt 404
      end

      # ----- URL Helpers ---------- #
      def tags_path
        '/tags'
      end

      def tag_path(slug)
        File.join tags_path, slug
      end
    end
  end
end