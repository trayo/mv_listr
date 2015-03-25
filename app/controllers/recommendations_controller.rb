class RecommendationsController < ApplicationController
  before_action :require_current_user

  def index
    @recommendations = current_user.watched_recommendations(watched_status)
  end

  def create
    if search_params.empty?
      redirect_to recommendations_path, notice: "Search was empty."
    else
      @recommendation = Recommendation.find_or_create_media(search_params)
      assign_recommendation_to_user
    end
  end

  def update
    find_user_recommendation.update_attributes(watched: watched_status)
    redirect_to recommendations_path, alert: "Movie updated."
  end

  def destroy
    find_user_recommendation.destroy
    redirect_to recommendations_path, alert: "Movie deleted."
  end

  private

  def search_params
    params["search_1"] || params["search_2"]
  end

  def watched_status
    params["watched_status"]
  end

  def find_user_recommendation
    UserRecommendation.find_by(current_user_and_recommendation_id)
  end

  def current_user_and_recommendation_id
    {
      user_id: current_user,
      recommendation_id: params["id"]
    }
  end

  def recommendation_was_found?
    @recommendation != "Movie not found."
  end

  def user_already_has_recommendation?
    current_user.recommendations.exists?(imdb_ID: @recommendation.imdb_ID)
  end

  def assign_recommendation_to_user
    if recommendation_was_found? && user_already_has_recommendation?
      notice = "That movie has already been added."
    elsif recommendation_was_found?
      current_user.recommendations << @recommendation
      alert = "Movie found!"
    else
      notice = "Movie not found!"
    end

    notice ? flash[:notice] = notice : flash[:alert] = alert
    redirect_to recommendations_path
  end
end
