class FrancisCMS < Sinatra::Base
  namespace '/tags' do
    get '' do
      @tags = Tag.all.order('name ASC')

      erb :'tags/index'
    end

    get '/:slug' do
      tag

      @posts = Post.tagged_with(@tag.name)
      @links = Link.tagged_with(@tag.name)

      erb :'tags/show'
    end
  end
end