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

          @posts = @tag.posts
          @links = @tag.links

          unless logged_in?
            @posts = @posts.exclude_drafts
            @links = @links.exclude_drafts
          end

          @page_title = "Content tagged “#{tag.name}”"

          erb :'tags/show'
        end
      end
    end
  end
end