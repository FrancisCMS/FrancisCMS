class FrancisCMS < Sinatra::Base
  helpers do
    def links_path
      '/links'
    end

    def link_path(id)
      "#{links_path}/#{id}"
    end

    def new_link_path
      "#{links_path}/new"
    end

    def edit_link_path(id)
      "#{link_path(id)}/edit"
    end
  end
end