class FrancisCMS < Sinatra::Base
  namespace '/links' do
    get '' do
      @links = Link.all.order('published_at DESC')
      @page_title = 'Links'

      erb :'links/index'
    end

    post '' do
      require_login
      @link = Link.new(params[:link].merge(published_at: Time.now))

      if @link.save
        redirect link_path(@link.id)
      else
        @page_title = 'Add a new link'

        erb :'links/new'
      end
    end

    get '/new' do
      require_login
      @link = Link.new
      @page_title = 'Add a new link'

      erb :'links/new'
    end

    namespace '/:id' do
      get '' do
        link
        @page_title = "#{@link.title} — Links"

        erb :'links/show'
      end

      put '' do
        require_login
        link

        if @link.update_attributes(params[:link])
          redirect link_path(@link.id)
        else
          @page_title = "Editing “#{@link.title}”"

          erb :'links/edit'
        end
      end

      delete '' do
        require_login
        link.destroy

        redirect links_path
      end

      get '/edit' do
        require_login
        link
        @page_title = "Editing “#{@link.title}”"

        erb :'links/edit'
      end
    end
  end
end