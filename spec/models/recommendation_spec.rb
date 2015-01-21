require 'rails_helper'

RSpec.describe Recommendation, :type => :model do
  describe "validations" do
    it "is valid" do
      recommendation = build(:recommendation)

      expect(recommendation).to be_valid
    end

    it "is invalid if it's missing an attribute" do
      recommendation = build(:recommendation, title: "Looper")

      recommendation.title = nil
      expect(recommendation).to_not be_valid

      recommendation.title = ''
      expect(recommendation).to_not be_valid
    end
  end

  describe "finding media" do
    it "can find a movie" do
      movie = Recommendation.find_or_create_media("looper", "movie")

      expect(movie.title).to eq("Looper")
    end

    it "can find a movie that exists in the database" do
      create(:recommendation, title: "looper")
      movie = Recommendation.find_or_create_media("looper")

      expect(movie.title).to eq("looper")
    end
  end
end
