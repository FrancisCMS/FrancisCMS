require_dependency 'francis_cms/francis_cms_controller'

module FrancisCms
  class WebmentionsController < FrancisCmsController
    before_action :require_login, only: [:update, :destroy]

    protect_from_forgery except: [:create]

    def index
      webmentions
    end

    def show
      webmention
    end

    def create
      source = params[:source]
      target = params[:target]

      @webmention = Webmention.where(source: source, target: target).first_or_create(source: source, target: target)

      if @webmention.save
        if params[:referer] == FrancisCms.configuration.site_url
          redirect_to webmention_path(@webmention), notice: 'Thanks for submitting a webmention! It’s been placed in the queue for verification.'
        else
          render text: webmention_url(@webmention), status: :accepted
        end
      else
        head :bad_request
      end
    end

    def update
      if webmention.verify
        redirect_to @webmention, notice: 'This webmention was successfully verified!'
      else
        redirect_to webmentions_path, alert: 'That webmention appears to be invalid.'
      end
    end

    def destroy
      webmention.destroy

      redirect_to webmentions_path, notice: 'You’ve successfully deleted that webmention. It’s gone for good!'
    end

    private

    def webmentions
      @webmentions ||= Webmention.page(params['page']).order('created_at DESC')
    end

    def webmention
      @webmention ||= Webmention.find(params[:id])
    end
  end
end
