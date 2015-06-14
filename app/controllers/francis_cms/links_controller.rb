require_dependency 'francis_cms/francis_cms_controller'

module FrancisCms
  class LinksController < FrancisCmsController
    before_action :require_login, except: [:index, :show]

    def index
      links
    end

    def show
      link

      require_login unless link.published_at?
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
      params.require(:link).permit(:url, :title, :body, :tag_list, :is_draft)
    end

    def links
      @links ||= Link.entries_for_page({ include_drafts: __logged_in__, page: params['page'] })
    end

    def link
      @link ||= Link.find(params[:id])
    end
  end
end
