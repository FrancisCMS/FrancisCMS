class FrancisCMS < Sinatra::Base
  get '/' do
    erb :index
  end

  not_found do
    erb :'404'
  end
end