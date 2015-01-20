class SessionsController < ApplicationController
  def create
    user = User.find_or_create_by_auth(auth_data)
    session["user_id"] = user.id
    redirect_to recommendations_path
  end

  def destroy
    session.clear
    redirect_to root_path, notice: 'Logged out'
  end

  protected

  def auth_data
    request.env["omniauth.auth"]
  end
end