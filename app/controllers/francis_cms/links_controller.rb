require_dependency 'francis_cms/francis_cms_controller'

module FrancisCms
  class LinksController < FrancisCmsController
    before_action :require_login, except: [:index, :show]

    def index
      links
    end

    def show
      require_login unless link.published_at?
    end

    def new
      @link = Link.new(LinkInput.new(params).to_h)
    end

    def create
      @link = Link.new(LinkInput.new(params).to_h)

      if @link.save
        redirect_to @link, notice: t('flashes.links.create_notice')
      else
        render 'new'
      end
    end

    def edit
      link
    end

    def update
      if link.update(LinkInput.new(params).to_h)
        redirect_to @link, notice: t('flashes.links.update_notice')
      else
        render 'edit'
      end
    end

    def destroy
      link.destroy

      redirect_to links_path, notice: t('flashes.links.destroy_notice')
    end

    private

    def links
      @links ||= Link.entries_for_page(include_drafts: __logged_in__, page: params['page'])
    end

    def link
      @link ||= Link.find(params[:id])
    end
  end
end
