module FrancisCMS
  module Routes
    class Feeds < Base
      get %r{(links|posts)/rss}, provides: 'application/rss+xml' do |param|
        content_type :xml

        klass = param.capitalize.singularize.constantize

        @feed_items = klass.send("recent_#{param}_for_feed")

        @feed_title = "#{settings.site['title']}: #{param.capitalize}"
        @feed_description = "Recent #{param} from #{settings.site['title']} — #{settings.site['description']}"
        @feed_url = feed_url(param)
        @url = send("#{param}_url")

        erb :rss, layout: false
      end
    end
  end
end