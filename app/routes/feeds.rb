module FrancisCMS
  module Routes
    class Feeds < Base
      get '/posts/atom', provides: 'application/atom+xml' do
        content_type :xml

        @feed_items = Post.recent_posts_for_feed

        @feed_title = "#{settings.site['title']}: Posts"
        @feed_subtitle = "All posts from #{settings.site['title']} — #{settings.site['description']}"
        @feed_url = posts_atom_url
        @url = posts_url

        erb :'feeds/atom', layout: false
      end

      get '/posts/rss', provides: 'application/rss+xml' do
        content_type :xml

        @feed_items = Post.recent_posts_for_feed

        @feed_title = "#{settings.site['title']}: Posts"
        @feed_description = "All posts from #{settings.site['title']} — #{settings.site['description']}"
        @feed_url = posts_rss_url
        @url = posts_url

        erb :'feeds/rss', layout: false
      end
    end
  end
end