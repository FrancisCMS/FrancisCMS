module FrancisCMS
  module Helpers
    module FeedsHelper
      def feed_item_url(feed_item)
        klass = feed_item.class
        klass_string = klass.name.demodulize.downcase
        param = klass.method_defined?(:slug) ? feed_item.slug : feed_item.id

        url_for send("#{klass_string}_path", param)
      end

      def feed_path(content_type)
        send("#{content_type}_path") + '/rss'
      end
    end
  end
end