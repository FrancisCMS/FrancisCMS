module FrancisCms
  module Syndications
    class Medium
      CLIENT_PARAMS = {
        integration_token: Rails.application.secrets.medium_integration_token
      }

      def initialize(syndicatable, canonical_url)
        @syndicatable = syndicatable
        @canonical_url = canonical_url

        @client = ::Medium::Client.new(CLIENT_PARAMS)
      end

      def publish
        response = @client.posts.create(@client.users.me, options)

        {
          name: 'Medium',
          url: JSON.parse(response.body)['data']['url']
        }
      rescue => error
        # log `error.message`
      end

      private

      def options
        {
          title: @syndicatable.title,
          content_format: 'html',
          content: post_content,
          canonical_url: @canonical_url,
          tags: post_tags,
          license: 'cc-40-by-nc-sa'
        }
      end

      def post_content
        %{
          <h1>#{@syndicatable.title}</h1>
          #{@syndicatable.to_html.gsub(/\shref="\//, %{ href="#{FrancisCms.configuration.site_url}})}
          <hr>
          <p><i>This post was originally published on <a href="#{@canonical_url}" rel="canonical">my own site</a>.</i></p>
        }
      end

      def post_tags
        @syndicatable.tags.take(3).collect(&:name)
      end
    end
  end
end
