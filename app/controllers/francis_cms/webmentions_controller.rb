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
        return redirect_to webmention_path(@webmention), notice: t('flashes.webmentions.create_notice') if params[:referer]

        render text: webmention_url(@webmention), status: :accepted
      else
        return redirect_to URI.parse(params[:referer]).path, alert: t('flashes.webmentions.create_alert') if params[:referer]

        head :bad_request
      end
    end

    def update
      if webmention.verify && webmention.verified_at?
        redirect_to @webmention, notice: t('flashes.webmentions.update_notice')
      else
        redirect_to webmentions_path, alert: t('flashes.webmentions.update_alert')
      end
    end

    def destroy
      webmention.destroy

      redirect_to webmentions_path, notice: t('flashes.webmentions.destroy_notice')
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
