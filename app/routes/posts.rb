class FrancisCMS < Sinatra::Base
  namespace '/posts' do
    get '' do
      @posts = Post.all

      erb :'posts/index'
    end

    post '' do
      @post = Post.new(params[:post].merge(published_at: Time.now))

      if @post.save
        redirect post_path(@post.slug)
      else
        erb :'posts/new'
      end
    end

    get '/new' do
      @post = Post.new

      erb :'posts/new'
    end

    namespace '/:slug' do
      get '' do
        begin
          @post = Post.friendly.find(params[:slug])

          erb :'posts/show'
        rescue ActiveRecord::RecordNotFound => e
          404
        end
      end
    end
  end
end