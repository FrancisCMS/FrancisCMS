module FrancisCMS
  module Routes
    class Main < Base
      get '/' do
        erb :index
      end

      not_found do
        erb :'404'
      end
    end
  end
end