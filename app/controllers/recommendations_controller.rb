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
      if recommendation_is_a_movie?
        current_user.recommendations << @recommendation
        redirect_to recommendations_path, notice: "Movie found!"
      else
        redirect_to recommendations_path, notice: "Movie not found!"
      end
    else
      redirect_to recommendations_path, notice: "Search was empty."
    end
  end

  private

  def recommendation_is_a_movie?
    @recommendation.class.to_s != "String"
  end
end
