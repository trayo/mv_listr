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

      if found_a_movie?
        current_user.recommendations << @recommendation
        redirect_to :back, notice: "Movie found!"
      else
        redirect_to :back, notice: "Movie not found!"
      end
    else
      redirect_to :back, notice: "Search was empty."
    end
  end

  private

  def found_a_movie?
    @recommendation.class.to_s != "String"
  end
end
