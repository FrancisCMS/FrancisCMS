class FrancisCMS < Sinatra::Base
  get '/login' do
    if logged_in?
      redirect root_path
    else
      erb :login
    end
  end

  post '/logout' do
    session.clear

    redirect root_path
  end

  get '/auth' do
    auth_code
    next_page = login_path

    url = auth_code_is_valid?({
      client_id: base_url,
      code: auth_code,
      redirect_uri: auth_url
    })

    if url && url == settings.user['url']
      session[:user_id] = url

      next_page = root_path
    end

    redirect next_page
  end
end