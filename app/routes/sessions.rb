class FrancisCMS < Sinatra::Base
  get '/login' do
    erb :login
  end

  post '/logout' do
    session.clear
    redirect root_path
  end

  get '/auth' do
    code = params[:code]

    if code.nil?
      400
    else
      begin
        agent = Mechanize.new

        page = agent.post('https://indieauth.com/auth', {
          client_id: base_url,
          code: code,
          redirect_uri: auth_url
        })

        response = CGI::parse(page.content)

        if response.key?('me') && response['me'].first == settings.user['url']
          session[:user_id] = response['me'].first

          redirect root_path
        else
          redirect login_path
        end
      rescue Mechanize::ResponseCodeError => e
        redirect login_path
      end
    end
  end
end