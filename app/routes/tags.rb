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

          # Get @posts and @links tagged with @tag.name

          @page_title = "Content tagged “#{tag.name}”"

          erb :'tags/show'
        end
      end
    end
  end
end