module FrancisCMS
  module Routes
    class Feeds < Base
      get %r{(links|posts)/rss}, provides: 'application/rss+xml' do |param|
        content_type :xml

        klass = param.capitalize.singularize.constantize

        @feed_items = klass.send('recent_items')

        @feed_title = "#{settings.site['title']}: #{param.capitalize}"
        @feed_description = "Recent #{param} from #{settings.site['title']} — #{settings.site['description']}"
        @feed_url = url_for feed_path(param)
        @url = url_for send("#{param}_path")

        erb :rss, layout: false
      end
    end
  end
end