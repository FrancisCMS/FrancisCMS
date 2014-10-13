module FrancisCMS
  module Helpers
    module PostsHelper
      def post
        @post ||= Post.find(params[:slug])
      rescue ActiveRecord::RecordNotFound
        halt 404
      end

      # ----- URL Helpers ---------- #
      def posts_path
        '/posts'
      end

      def post_path(slug)
        "#{posts_path}/#{slug}"
      end

      def new_post_path
        "#{posts_path}/new"
      end

      def edit_post_path(slug)
        "#{post_path(slug)}/edit"
      end
    end
  end
end