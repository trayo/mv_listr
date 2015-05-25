require "rails_helper"

RSpec.describe TwilioController do
  describe "user sends an sms" do
    it "assigns a movie to the user" do
      user = create(:user, phone_number: "+16667778888")
      movie_title = "looper"

      expect(user.recommendations).to be_empty

      send_post_with_params(movie_title, user.phone_number)

      expect(user.recommendations.count).to eq(1)
      expect(user.recommendations.first.title).to eq("looper")
    end
  end

  def send_post_with_params(movie, phone_number)
    VCR.use_cassette "twilio post" do
      post :create, post_params(movie, phone_number)
    end
  end

  def post_params(movie, phone_number)
    {
      "Body": movie,
      "From": phone_number,
      "format": "json",
    }
  end
end
