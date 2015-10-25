class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    if User.exists?(phone_number: params["From"])
      @recommendation = Recommendation.find_or_create_media(search_params)
      set_user_using_twilio_phone_number
      assign_recommendation_to_user
    end
    render nothing: true, status: 200
  end

  private

  def search_params
    params["Body"]
  end

  def recommendation_was_found?
    @recommendation != "Movie not found."
  end

  def user_already_has_recommendation?
    @twilio_user.recommendations.exists?(imdb_ID: @recommendation.imdb_ID)
  end

  def set_user_using_twilio_phone_number
    @twilio_user = User.find_by("phone_number = ?", params["From"])
  end

  def assign_recommendation_to_user
    if recommendation_was_found? && user_already_has_recommendation?
      # Placeholder for sending a message back to the user
      # that says they already added that movie
    elsif recommendation_was_found?
      @twilio_user.recommendations << @recommendation
    else
      # Placeholder for sending a message back to the user
      # that says the movie wasn't found
    end
  end
end
