require_dependency 'francis_cms/francis_cms_controller'

module FrancisCms
  class SyndicationsController < FrancisCmsController
    before_action :require_login

    def create
      @syndication = syndicatable.syndications.new(SyndicationInput.new(params).to_h)

      if @syndication.save
        flash[:notice] = 'Syndication added successfully!'
      else
        flash[:error] = 'There was a problem saving that syndication. Mind trying again?'
      end

      redirect_to send("edit_#{resource_type.singularize}_path", syndicatable)
    end

    def destroy
      syndication.destroy

      redirect_to send("edit_#{resource_type.singularize}_path", syndicatable), notice: 'You’ve successfully deleted that syndication. It’s gone for good!'
    end

    private

    def parent_class
      @parent_class ||= "FrancisCms::#{resource_type.classify}".constantize
    end

    def syndicatable
      @syndicatable ||= parent_class.find(params["#{resource_type.singularize}_id"])
    end

    def syndication
      @syndication ||= Syndication.find(params[:id])
    end
  end
end
