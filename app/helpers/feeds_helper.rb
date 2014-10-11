module FrancisCMS
  module Helpers
    module FeedsHelper
      def feed_item_url(feed_item)
        klass = feed_item.class
        klass_string = klass.name.demodulize.downcase
        param = klass.method_defined?(:slug) ? feed_item.slug : feed_item.id

        send("#{klass_string}_url", param)
      end

      def posts_atom_path
        "#{posts_path}/atom"
      end

      def posts_atom_url
        base_url + posts_atom_path
      end

      def posts_rss_path
        "#{posts_path}/rss"
      end

      def posts_rss_url
        base_url + posts_rss_path
      end
    end
  end
end