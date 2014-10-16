module FrancisCMS
  module Helpers
    module LinksHelper
      def link
        @link ||= Link.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        halt 404
      end
    end
  end
end