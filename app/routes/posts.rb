class FrancisCMS < Sinatra::Base
  namespace '/posts' do
    get '' do
      @posts = Post.all

      erb :'posts/index'
    end

    get '/:slug' do
      begin
        @post = Post.friendly.find(params[:slug])

        erb :'posts/show'
      rescue ActiveRecord::RecordNotFound => e
        404
      end
    end
  end
end