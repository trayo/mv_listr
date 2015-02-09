class WatchedRecommendationsController < ApplicationController

  def index
    if current_user
      @recommendations = current_user.watched_recommendations(true)
    else
      redirect_to root_path, notice: "You must be logged in to access that page."
    end
  end

  def destroy
    UserRecommendation.find_by(user_id: current_user, recommendation_id: params["id"]).destroy
    redirect_to :back, alert: "Movie deleted."
  end
end
