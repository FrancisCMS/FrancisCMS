class LinksController < ApplicationController
  before_action :require_login, except: [:index, :show]

  def index
    links
  end

  def show
    link
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)

    if @link.save
      redirect_to @link
    else
      render 'new'
    end
  end

  def edit
    link
  end

  def update
    if link.update_attributes(link_params)
      redirect_to @link
    else
      render 'edit'
    end
  end

  def destroy
    link.destroy

    redirect_to links_path
  end

  private

  def link_params
    params.require(:link).permit(:url, :title, :body, :is_draft)
  end

  def links
    @links ||= Link.all.order('created_at DESC')
  end
  helper_method :links

  def link
    @link ||= Link.find(params[:id])
  end
  helper_method :link
end
