class ApplicationController < ActionController::Base
  before_action :authorize

  protected 

    def authorize
      unless User.find_by(email: session[:email])
        redirect_to login_url, notice: 'Please log in'
      end
    end
end
