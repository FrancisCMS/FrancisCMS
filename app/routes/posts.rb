class FrancisCMS < Sinatra::Base
  namespace '/posts' do
    get '' do
      @posts = Post.all

      erb :'posts/index'
    end

    get '/:slug' do
      @post = Post.friendly.find(params[:slug])

      if @post
        erb :'posts/show'
      else
        404
      end
    end
  end
end