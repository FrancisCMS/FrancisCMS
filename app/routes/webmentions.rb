module FrancisCMS
  module Routes
    class Webmentions < Base
      helpers Helpers::WebmentionsHelper

      namespace '/webmentions' do
        get '' do
          erb :'webmentions/index'
        end

        post '' do
          source = params[:source]
          target = params[:target]

          webmention = Webmention.where(source: source, target: target).first_or_create(source: source, target: target)

          webmention.verified_at = nil

          if webmention.save
            status 202

            if params[:referer] == settings.site['url']
              redirect_to webmention_url(webmention)
            else
              erb webmention_url(webmention), layout: false
            end
          else
            status 400
          end
        end

        namespace '/:id' do
          get '' do
            webmention

            erb :'webmentions/show'
          end

          put '' do
            require_login
            webmention.verify

            # TODO: if @webmention exists, redirect to it; otherwise, redirect to webmentions_path
            redirect webmention_path(@webmention)
          end

          delete '' do
            require_login
            webmention.destroy

            redirect webmentions_path
          end
        end
      end
    end
  end
end