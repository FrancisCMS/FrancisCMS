class FrancisCMS < Sinatra::Base
  namespace '/links' do
    get '' do
      @links = Link.all

      erb :'links/index'
    end

    get '/:id' do
      @link = Link.find(params[:id])

      if @link
        erb :'links/show'
      else
        404
      end
    end
  end
end