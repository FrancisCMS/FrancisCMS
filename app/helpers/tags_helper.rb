module FrancisCMS
  module Helpers
    module TagsHelper
      def tag
        @tag ||= Tag.find(params[:slug])
      rescue ActiveRecord::RecordNotFound
        halt 404
      end
    end
  end
end