class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def logged_in?
    session[:user_id] && session[:user_id] == Settings.user.url
  end
  helper_method :logged_in?

  def require_login
    redirect_to login_path unless logged_in?
  end
end
