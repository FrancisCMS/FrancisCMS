require_dependency 'francis_cms/francis_cms_controller'

module FrancisCms
  class PostsController < FrancisCmsController
    before_action :require_login, except: [:index, :show]

    def index
      posts
    end

    def show
      require_login unless post.published_at?
    end

    def new
      @post = Post.new
    end

    def create
      @post = Post.new(post_params)

      if (Post.where(slug: @post.slug).first)
        @post.slug = nil;
      end

      if @post.save
        redirect_to @post
      else
        render 'new'
      end
    end

    def edit
      post
    end

    def update
      if post.update_attributes(post_params)
        redirect_to @post
      else
        render 'edit'
      end
    end

    def destroy
      post.destroy

      redirect_to posts_path
    end

    private

    def post_params
      params.require(:post).permit(:title, :slug, :body, :excerpt, :tag_list, :is_draft)
    end

    def posts
      @posts ||= Post.entries_for_page({ include_drafts: __logged_in__, page: params['page'] })
    end

    def post
      @post ||= Post.find(params[:id])
    end
  end
end
