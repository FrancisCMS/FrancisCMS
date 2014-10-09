class FrancisCMS < Sinatra::Base
  helpers do
    # ----- Routes ---------- #
    def tags_path
      '/tags'
    end

    def tag_path(name)
      "#{tags_path}/#{name}"
    end
  end
end