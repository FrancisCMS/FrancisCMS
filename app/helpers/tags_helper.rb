module FrancisCMS
  module Helpers
    module TagsHelper
      def tag
        @tag ||= Tag.friendly.find(params[:slug])
      rescue ActiveRecord::RecordNotFound
        halt 404
      end

      # ----- URL Helpers ---------- #
      def tags_path
        '/tags'
      end

      def tag_path(slug)
        "#{tags_path}/#{slug}"
      end
    end
  end
end