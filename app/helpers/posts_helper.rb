class FrancisCMS < Sinatra::Base
  helpers do
    def posts_path
      '/posts'
    end

    def post_path(slug)
      "#{posts_path}/#{slug}"
    end
  end
end