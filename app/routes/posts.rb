module FrancisCMS
  module Routes
    class Posts < Base
      helpers Helpers::PostsHelper
      helpers Helpers::TaggablesHelper

      namespace '/posts' do
        get '' do
          @posts = Post.recent_items(include_drafts: logged_in?)
          @page_title = 'Posts'

          erb :'posts/index'
        end

        post '' do
          require_login

          @post = Post.new(generate_taggable_params(params[:post]))

          if @post.save
            redirect post_path(@post)
          else
            @page_title = 'Add a new post'

            erb :'posts/new'
          end
        end

        get '/new' do
          require_login
          @post = Post.new
          @page_title = 'Add a new post'

          erb :'posts/new'
        end

        namespace '/:slug' do
          get '' do
            post
            @page_title = @post.title

            unless @post.excerpt.blank?
              @page_description = @post.excerpt
            end

            erb :'posts/show'
          end

          put '' do
            require_login
            post

            if @post.update_attributes(generate_taggable_params(params[:post]))
              redirect post_path(@post)
            else
              @page_title = "Editing “#{@post.title}”"

              erb :'posts/edit'
            end
          end

          delete '' do
            require_login
            post.destroy

            redirect posts_path
          end

          get '/edit' do
            require_login
            post
            @page_title = "Editing “#{@post.title}”"

            erb :'posts/edit'
          end
        end
      end
    end
  end
end