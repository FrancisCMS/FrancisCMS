class FrancisCMS < Sinatra::Base
  helpers do
    def auth_code
      @auth_code ||= params[:code] || halt(400)
    end

    def auth_code_is_valid?(params)
      is_valid = false

      begin
        agent = Mechanize.new

        page = agent.post('https://indieauth.com/auth', params)
        response = CGI::parse(page.content)

        if response.key? 'me'
          is_valid = response['me'].first
        end
      rescue Mechanize::ResponseCodeError
      end

      is_valid
    end

    def logged_in?
      return !!session[:user_id]
    end

    def require_login
      redirect login_path unless logged_in?
    end

    # ----- Routes ---------- #
    def auth_path
      '/auth'
    end

    def auth_url
      base_url + auth_path
    end

    def login_path
      '/login'
    end

    def logout_path
      '/logout'
    end
  end
end