class FrancisCMS < Sinatra::Base
  helpers do
    def post
      @post ||= Post.friendly.find(params[:slug])
    rescue ActiveRecord::RecordNotFound
      halt 404
    end

    # ----- Routes ---------- #
    def posts_path
      '/posts'
    end

    def post_path(slug)
      "#{posts_path}/#{slug}"
    end

    def new_post_path
      "#{posts_path}/new"
    end

    def edit_post_path(id)
      "#{post_path(id)}/edit"
    end
  end
end