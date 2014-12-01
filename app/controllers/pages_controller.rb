class PagesController < ApplicationController
  def homepage
    @posts = Post.recently_published
    @links = Link.recently_published
  end
end
