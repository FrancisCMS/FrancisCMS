class FrancisCMS < Sinatra::Base
  namespace '/posts' do
    get '' do
      @posts = Post.all

      erb :'posts/index'
    end

    post '' do
      require_login

      @post = Post.new(params[:post].merge(published_at: Time.now))

      if @post.save
        redirect post_path(@post.slug)
      else
        erb :'posts/new'
      end
    end

    get '/new' do
      require_login

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

      put '' do
        require_login

        @post = Post.friendly.find(params[:slug])

        if @post.update_attributes(params[:post])
          redirect post_path(@post.slug)
        else
          erb :'posts/edit'
        end
      end

      delete '' do
        require_login

        Post.friendly.find(params[:slug]).destroy

        redirect posts_path
      end

      get '/edit' do
        require_login

        @post = Post.friendly.find(params[:slug])

        if @post
          erb :'posts/edit'
        else
          404
        end
      end
    end
  end
end