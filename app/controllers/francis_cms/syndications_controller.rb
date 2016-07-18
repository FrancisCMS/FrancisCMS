require_dependency 'francis_cms/francis_cms_controller'

module FrancisCms
  class SyndicationsController < FrancisCmsController
    before_action :require_login

    def create
      @syndication = syndicatable.syndications.new(SyndicationInput.new(params).to_h)

      if @syndication.save
        flash[:notice] = t('flashes.syndications.create_notice')
      else
        flash[:alert] = t('flashes.syndications.create_alert')
      end

      redirect_to send("edit_#{resource_type.singularize}_path", syndicatable)
    end

    def destroy
      syndication.destroy

      redirect_to send("edit_#{resource_type.singularize}_path", syndicatable), notice: t('flashes.syndications.destroy_notice')
    end

    def flickr
      @syndication = syndicatable.syndications.new(Syndications::Flickr.new(syndicatable, canonical_url).publish)

      if @syndication.save
        flash[:notice] = t('flashes.syndications.flickr_create_notice')
      else
        flash[:alert] = t('flashes.syndications.flickr_create_alert')
      end

      redirect_to send("edit_#{resource_type.singularize}_path", syndicatable)
    end

    def medium
      @syndication = syndicatable.syndications.new(Syndications::Medium.new(syndicatable, canonical_url).publish)

      if @syndication.save
        flash[:notice] = t('flashes.syndications.medium_create_notice')
      else
        flash[:alert] = t('flashes.syndications.medium_create_alert')
      end

      redirect_to send("edit_#{resource_type.singularize}_path", syndicatable)
    end

    def twitter
      @syndication = syndicatable.syndications.new(Syndications::Twitter.new(syndicatable, canonical_url).publish)

      if @syndication.save
        flash[:notice] = t('flashes.syndications.twitter_create_notice')
      else
        flash[:alert] = t('flashes.syndications.twitter_create_alert')
      end

      redirect_to send("edit_#{resource_type.singularize}_path", syndicatable)
    end

    private

    def canonical_url
      @canonical_url ||= send("#{resource_type.singularize}_url", syndicatable)
    end

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
