class FrancisCMS < Sinatra::Base
  helpers do
    def links_path
      '/links'
    end

    def link_path(id)
      "#{links_path}/#{id}"
    end
  end
end