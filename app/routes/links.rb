module FrancisCMS
  module Routes
    class Links < Base
      helpers Helpers::LinksHelper
      helpers Helpers::TaggablesHelper

      namespace '/links' do
        get '' do
          @links = Link.recent_items(include_drafts: logged_in?)
          @page_title = 'Links'

          erb :'links/index'
        end

        post '' do
          require_login
          @link = Link.new(generate_taggable_params(params[:link]))

          if @link.save
            redirect link_path(@link.id)
          else
            @page_title = 'Add a new link'

            erb :'links/new'
          end
        end

        get '/new' do
          require_login
          @link = Link.new
          @page_title = 'Add a new link'

          erb :'links/new'
        end

        namespace '/:id' do
          get '' do
            link
            @page_title = "#{@link.title} — Links"

            erb :'links/show'
          end

          put '' do
            require_login
            link

            if @link.update_attributes(generate_taggable_params(params[:link]))
              redirect link_path(@link.id)
            else
              @page_title = "Editing “#{@link.title}”"

              erb :'links/edit'
            end
          end

          delete '' do
            require_login
            link.destroy

            redirect links_path
          end

          get '/edit' do
            require_login
            link
            @page_title = "Editing “#{@link.title}”"

            erb :'links/edit'
          end
        end
      end
    end
  end
end