module FrancisCMS
  module Helpers
    module PostsHelper
      def post
        @post ||= Post.friendly.find(params[:slug])
      rescue ActiveRecord::RecordNotFound
        halt 404
      end

      def posts_path
        '/posts'
      end

      def posts_url
        base_url + posts_path
      end

      def post_path(slug)
        "#{posts_path}/#{slug}"
      end

      def post_url(slug)
        base_url + post_path(slug)
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