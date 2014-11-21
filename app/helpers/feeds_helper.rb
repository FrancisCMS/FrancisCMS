module FrancisCMS
  module Helpers
    module FeedsHelper
      def feed_item_url(feed_item)
        send("#{feed_item.class.name.demodulize.downcase}_url", feed_item)
      end
    end
  end
end