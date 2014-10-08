class FrancisCMS < Sinatra::Base
  namespace '/links' do
    get '' do
      @links = Link.all

      erb :'links/index'
    end

    post '' do
      require_login

      @link = Link.new(params[:link].merge(published_at: Time.now))

      if @link.save
        redirect link_path(@link.id)
      else
        erb :'links/new'
      end
    end

    get '/new' do
      require_login

      @link = Link.new

      erb :'links/new'
    end

    namespace '/:id' do
      get '' do
        @link = Link.find_by_id(params[:id])

        if @link
          erb :'links/show'
        else
          404
        end
      end

      put '' do
        require_login

        @link = Link.find(params[:id])

        if @link.update_attributes(params[:link])
          redirect link_path(@link.id)
        else
          erb :'links/edit'
        end
      end

      delete '' do
        require_login

        Link.find(params[:id]).destroy

        redirect links_path
      end

      get '/edit' do
        require_login

        @link = Link.find_by_id(params[:id])

        if @link
          erb :'links/edit'
        else
          404
        end
      end
    end
  end
end