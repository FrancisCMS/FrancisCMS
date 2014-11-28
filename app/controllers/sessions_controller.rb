class SessionsController < ApplicationController
  def create
    auth_code = params[:code]

    begin
      agent = Mechanize.new

      page = agent.post('https://indieauth.com/auth', { client_id: root_url, code: auth_code, redirect_uri: auth_url })
      response = CGI::parse(page.content)

      if response.key?('me')
        url = response['me'].first

        if url == Settings.user.url
          session[:user_id] = url
        end
      end
    rescue Mechanize::ResponseCodeError
    end

    redirect_to root_path
  end

  def destroy
    reset_session

    redirect_to root_path
  end
end
