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
        redirect_to @link, notice: 'Successfully saved your new link! Here’s what it looks like.'
      else
        render 'new'
      end
    end

    def edit
      link
    end

    def update
      if link.update_attributes(LinkInput.new(params).to_h)
        redirect_to @link, notice: 'Success! Here’s what your updated link looks like.'
      else
        render 'edit'
      end
    end

    def destroy
      link.destroy

      redirect_to links_path, notice: 'You’ve successfully deleted that link. It’s gone for good!'
    end

    private

    def links
      @links ||= Link.entries_for_page({ include_drafts: __logged_in__, page: params['page'] })
    end

    def link
      @link ||= Link.find(params[:id])
    end
  end
end
