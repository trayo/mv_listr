class RecommendationsController < ApplicationController

  def index
    if current_user
      @recommendations = current_user.watched_recommendations(false).order(updated_at: :desc)
    else
      redirect_to root_path, notice: "You must be logged in to access that page."
    end
  end

  def create
    if params["Body"]
      params["search"] = params["Body"]
      @current_user = User.find_by("phone_number = ?", "+16617069773")
    end

    if search_params.empty?
      redirect_to recommendations_path, notice: "Search was empty."
    else
      @recommendation = Recommendation.find_or_create_media(search_params)
      assign_recommendation_to_user
    end
  end

  def update
    user_recommendation = UserRecommendation.find_by(user_id: current_user, recommendation_id: params["id"])
    user_recommendation.update_attributes(watched: true)
    redirect_to recommendations_path, alert: "Movie updated."
  end

  def destroy
    UserRecommendation.find_by(user_id: current_user, recommendation_id: params["id"]).destroy
    redirect_to recommendations_path, alert: "Movie deleted."
  end

  private

  def search_params
    params["search_1"] || params["search_2"]
  end

  def recommendation_is_a_movie?
    @recommendation.class.to_s != "String"
  end


  def user_already_has_recommendation
    if @current_user
      @current_user.recommendations.exists?(imdb_ID: @recommendation.imdb_ID)
    else
      current_user.recommendations.exists?(imdb_ID: @recommendation.imdb_ID)
    end
  end

  def assign_recommendation_to_user
    if recommendation_is_a_movie? && user_already_has_recommendation
      notice = "That movie has already been added."
    elsif recommendation_is_a_movie?

      if @current_user
        @current_user.recommendations << @recommendation
      else
        current_user.recommendations << @recommendation
      end
      alert = "Movie found!"

    else
      notice = "Movie not found!"
    end

    notice ? flash[:notice] = notice : flash[:alert] = alert
    redirect_to recommendations_path
  end
end
