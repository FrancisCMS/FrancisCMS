class FrancisCMS < Sinatra::Base
  helpers do
    def tag
      @tag ||= Tag.friendly.find(params[:slug])
    rescue ActiveRecord::RecordNotFound
      halt 404
    end

    # ----- Routes ---------- #
    def tags_path
      '/tags'
    end

    def tag_path(slug)
      "#{tags_path}/#{slug}"
    end
  end
end