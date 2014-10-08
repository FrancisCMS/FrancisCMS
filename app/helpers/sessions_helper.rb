class FrancisCMS < Sinatra::Base
  helpers do
    def auth_path
      '/auth'
    end

    def auth_url
      base_url + auth_path
    end

    def logged_in?
      return !!session[:user_id]
    end

    def login_path
      '/login'
    end

    def logout_path
      '/logout'
    end

    def require_login
      redirect login_path unless logged_in?
    end
  end
end