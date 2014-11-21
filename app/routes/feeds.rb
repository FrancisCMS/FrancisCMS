module FrancisCMS
  module Routes
    class Feeds < Base
      get %r{(links|posts)/rss}, provides: 'application/rss+xml' do |param|
        content_type :xml

        klass = param.capitalize.singularize.constantize

        @feed_items = klass.send 'entries_for_page'

        @feed_title = "#{settings.site['title']}: #{param.capitalize}"
        @feed_description = "Recent #{param} from #{settings.site['title']} — #{settings.site['description']}"
        @feed_url = send "#{param}_feed_url"
        @url = send "#{param}_url"

        erb :rss, layout: false
      end
    end
  end
end