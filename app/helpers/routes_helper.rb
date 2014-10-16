module FrancisCMS
  module Helpers
    module RoutesHelper
      # ----- Base ---------- #
      def url_for(path)
        base_url + path
      end

      def base_url
        @base_url ||= request.base_url
      end

      def root_path
        '/'
      end

      # ----- Links ---------- #
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

      # ----- Posts ---------- #
      def posts_path
        '/posts'
      end

      def post_path(slug)
        File.join posts_path, slug
      end

      def new_post_path
        File.join posts_path, 'new'
      end

      def edit_post_path(slug)
        File.join post_path(slug), 'edit'
      end

      # ----- Sessions ---------- #
      def auth_path
        '/auth'
      end

      def login_path
        '/login'
      end

      def logout_path
        '/logout'
      end

      # ----- Tags ---------- #
      def tags_path
        '/tags'
      end

      def tag_path(slug)
        File.join tags_path, slug
      end
    end
  end
end