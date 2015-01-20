class RecommendationsController < ApplicationController

  def index
    if current_user
      @recommendations = current_user.recommendations
    else
      redirect_to root_path, notice: "You must be logged in to access that page"
    end
  end
end
