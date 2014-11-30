class SyndicationsController < ApplicationController
  before_action :require_login
  before_action :find_syndicatable

  def create
    @syndication = @syndicatable.syndications.create(syndication_params)

    @syndication.save

    redirect_to edit_syndicatable_path
  end

  def destroy
    syndication.destroy

    redirect_to edit_syndicatable_path
  end

  private

  def syndication_params
    params.require(:syndication).permit(:name, :url)
  end

  def syndication
    @syndication ||= Syndication.find(params[:id])
  end

  def find_syndicatable
    params.each do |key, value|
      if key =~ /(.+)_id$/
        @syndicatable = $1.classify.constantize.find(value)
      end
    end
  end

  def edit_syndicatable_path
    send("edit_#{@syndicatable.class.name.downcase}_path", @syndicatable)
  end
end
