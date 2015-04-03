require_dependency 'francis_cms/francis_cms_controller'

module FrancisCms
  class SyndicationsController < FrancisCmsController
    before_action :require_login

    def create
      @syndication = syndicatable.syndications.new(syndication_params)

      @syndication.save

      redirect_to send("edit_#{parent}_path", syndicatable)
    end

    def destroy
      syndication.destroy

      redirect_to send("edit_#{parent}_path", syndicatable)
    end

    private

    def syndication_params
      params.require(:syndication).permit(:name, :url)
    end

    def parent
      @parent ||= %w(posts links).find { |p| request.path.split('/').include? p }.singularize
    end

    def parent_class
      @parent_class ||= "FrancisCms::#{parent.classify}".constantize
    end

    def syndicatable
      @syndicatable ||= parent_class.find(params["#{parent}_id"])
    end

    def syndication
      @syndication ||= Syndication.find(params[:id])
    end
  end
end
