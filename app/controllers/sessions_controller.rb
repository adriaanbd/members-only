class SessionsController < ApplicationController
  #skip_before_action :authorize_helper

  def new
  end

  def create
    @user = User.find_by(email: params[:email].downcase)
    if @user.try(:authenticate, params[:password])
      login @user
      params[:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_to @user, notice: "Hello #{@user.name}, you are signed in!"
    else
      redirect_to login_url, alert: "Invalid user/password combination"
    end
  end

  def destroy
    logout if logged_in?
    redirect_to users_url, notice: "Logged out"
  end
end
