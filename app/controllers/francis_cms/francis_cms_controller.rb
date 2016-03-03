module FrancisCms
  class FrancisCmsController < ApplicationController
    def __logged_in__
      public_send FrancisCms.configuration.logged_in_method
    end
    helper_method :__logged_in__

    def require_login
      redirect_to FrancisCms.configuration.login_path, alert: t('flashes.require_login') unless __logged_in__
    end

    def resource_type
      %w(links photos posts webmentions).find { |p| request.path.split('/').include? p }
    end
    helper_method :resource_type
  end
end
