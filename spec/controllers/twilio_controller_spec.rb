require 'rails_helper'

RSpec.describe TwilioController do
  describe "user sends an sms" do
    it "can send a post with params" do
      create(:user, phone_number: "+15554443333")

      send_post

      expect(response.status).to eq(200)
    end

    it "assigns a movie to the user" do
      user = create(:user, phone_number: "+15554443333")

      send_post

      expect(user.recommendations.first.title).to eq("looper")
    end
  end

  def send_post
    VCR.use_cassette "twilio post" do
      post :create, post_params
    end
  end

  def post_params
    {
      "Body": "looper",
      "From": "+15554443333",
      "format": "xml",
    }
  end
end
