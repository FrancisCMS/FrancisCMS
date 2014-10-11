module FrancisCMS
  module Routes
    class Root < Base
      get '/' do
        erb :index
      end

      not_found do
        erb :'404'
      end
    end
  end
end