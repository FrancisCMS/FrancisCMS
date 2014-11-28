class PostsController < ApplicationController
  before_action :require_login, except: [:index, :show]

  def index
    posts
  end

  def show
    post
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

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
    params.require(:post).permit(:title, :slug, :body, :excerpt, :is_draft)
  end

  def posts
    @posts ||= Post.all.order('created_at DESC')
  end
  helper_method :posts

  def post
    @post ||= Post.friendly.find(params[:id])
  end
  helper_method :post
end
