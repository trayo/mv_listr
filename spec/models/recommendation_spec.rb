require 'rails_helper'

RSpec.describe Recommendation, :type => :model do
  describe "validations" do
    it "is invalid if it's missing an attribute" do
      recommendation = build(:recommendation)

      recommendation.title = nil
      expect(recommendation).to_not be_valid

      recommendation.title = ""
      expect(recommendation).to_not be_valid
    end
  end

  describe "finding media" do
    it "can find a new movie" do
      VCR.use_cassette "recommendation" do
        movie = Recommendation.find_or_create_media("looper")

        expect(movie.title).to eq("looper")
      end
    end

    it "can find a movie that exists in the database" do
      create(:recommendation, title: "inception")
      movie = Recommendation.find_or_create_media("inception")

      expect(movie.title).to eq("inception")
    end

    it "can find a movie by imdb ID" do
      create(:recommendation, imdb_ID: "tt0909090")
      movie = Recommendation.find_or_create_media("tt0909090")

      expect(movie.imdb_ID).to eq("tt0909090")
    end
  end

  describe "filtering content" do
    it "filters adult content" do
      VCR.use_cassette "adult recommendation" do
        movie = Recommendation.find_or_create_media("blade 2")

        expect(movie).to eq("Movie not found.")
      end
    end
  end
end
