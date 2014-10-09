class FrancisCMS < Sinatra::Base
  helpers do
    def tag
      @tag ||= Tag.where(name: params[:name]).first
    rescue ActiveRecord::RecordNotFound
      halt 404
    end

    # ----- Routes ---------- #
    def tags_path
      '/tags'
    end

    def tag_path(name)
      "#{tags_path}/#{name}"
    end
  end
end