require_dependency 'francis_cms/francis_cms_controller'

module FrancisCms
  class SyndicationsController < FrancisCmsController
    before_action :require_login

    SILO_CLASSES = {
      flickr:  Syndications::Flickr,
      medium:  Syndications::Medium,
      twitter: Syndications::Twitter
    }

    def create
      @syndication = syndicatable.syndications.new(syndication_params)

      if @syndication.save
        flash[:notice] = t(['flashes', 'syndications', params[:silo], 'create_notice'].compact.join('.'))
      else
        flash[:alert] = t(['flashes', 'syndications', params[:silo], 'create_alert'].compact.join('.'))
      end

      redirect_to send("edit_#{resource_type.singularize}_path", syndicatable)
    end

    def destroy
      syndication.destroy

      redirect_to send("edit_#{resource_type.singularize}_path", syndicatable), notice: t('flashes.syndications.destroy_notice')
    end

    private

    def canonical_url
      @canonical_url ||= send("#{resource_type.singularize}_url", syndicatable)
    end

    def parent_class
      @parent_class ||= "FrancisCms::#{resource_type.classify}".constantize
    end

    def silo_class
      @silo_class ||= SILO_CLASSES[params[:silo].to_sym]
    end

    def syndicatable
      @syndicatable ||= parent_class.find(params["#{resource_type.singularize}_id"])
    end

    def syndication
      @syndication ||= Syndication.find(params[:id])
    end

    def syndication_params
      if params[:silo] && silo_class
        silo_class.new(syndicatable, canonical_url).publish
      else
        SyndicationInput.new(params).to_h
      end
    end
  end
end
