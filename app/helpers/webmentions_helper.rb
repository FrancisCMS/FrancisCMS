module FrancisCMS
  module Helpers
    module WebmentionsHelper
      def webmention
        @webmention ||= Webmention.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        halt 404
      end
    end
  end
end