module FrancisCMS
  module Routes
    class Tags < Base
      namespace '/tags' do
        get '' do
          @tags = Tag.all.order('name ASC')
          @page_title = 'Tags'

          erb :'tags/index'
        end

        get '/:slug' do
          tag

          @posts = Post.tagged_with(@tag.name)
          @links = Link.tagged_with(@tag.name)
          @page_title = "Content tagged “#{@tag.name}”"

          erb :'tags/show'
        end
      end
    end
  end
end