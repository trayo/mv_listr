class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :set_current_user

  helper_method :current_user

  def current_user
    @current_user
  end

  def set_current_user
    @current_user = User.find_by(id: session["user_id"])
  end
end
