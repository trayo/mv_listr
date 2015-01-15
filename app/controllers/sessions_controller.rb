class SessionsController < ApplicationController
  def create
    user = User.find_or_create_by_auth(auth_data)
    session["user_id"] = user.id
    redirect_to root_path
  end

  protected

  def auth_data
    request.env["omniauth.auth"]
  end
end
