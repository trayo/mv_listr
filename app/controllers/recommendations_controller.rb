class RecommendationsController < ApplicationController

  def index
    if current_user
      @recommendations = current_user.recommendations.order(updated_at: :desc)
    else
      redirect_to root_path, notice: "You must be logged in to access that page."
    end
  end

  def create
    unless params["search"].empty?
      @recommendation = Recommendation.find_or_create_media(params["search"])
      assign_recommendation_to_user
    else
      redirect_to recommendations_path, notice: "Search was empty."
    end
  end

  private

  def recommendation_is_a_movie?
    @recommendation.class.to_s != "String"
  end


  def user_already_has_recommendation
    current_user.recommendations.exists?(imdb_ID: @recommendation.imdb_ID)
  end

  def assign_recommendation_to_user
    case
    when recommendation_is_a_movie? && user_already_has_recommendation
      redirect_to recommendations_path, notice: "That movie is already on this list."
    when recommendation_is_a_movie?
      current_user.recommendations << @recommendation
      redirect_to recommendations_path, notice: "Movie found!"
    else
      redirect_to recommendations_path, notice: "Movie not found!"
    end
  end
end
