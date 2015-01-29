require 'rails_helper'

RSpec.describe "Searching for media" do
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
  end

  describe "filtering content" do
    it 'filters adult content' do
      VCR.use_cassette "adult recommendation" do
        movie = Recommendation.find_or_create_media("blade 2")

        expect(movie).to eq("Adult movie found.")
      end
    end
  end
end
