module FrancisCMS
  module Helpers
    module FeedsHelper
      def feed_item_url(feed_item)
        klass = feed_item.class
        klass_string = klass.name.demodulize.downcase
        param = klass.method_defined?(:slug) ? feed_item.slug : feed_item.id

        send("#{klass_string}_url", param)
      end

      def feed_path(content_type)
        send("#{content_type}_path") + '/rss'
      end

      def feed_url(content_type)
        base_url + feed_path(content_type)
      end
    end
  end
end