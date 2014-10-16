module FrancisCMS
  module Helpers
    module PostsHelper
      def post
        @post ||= Post.find(params[:slug])
      rescue ActiveRecord::RecordNotFound
        halt 404
      end
    end
  end
end