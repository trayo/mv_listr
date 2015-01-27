require 'rails_helper'

RSpec.describe OmdbService do

  describe 'validation' do
    it 'has a connection' do
      omdb = OmdbService.new.connection

      expect(omdb.url_prefix.to_s).to eq("http://omdbapi.com/")
    end

    it 'can find a movie' do
      omdb = OmdbService.new

      VCR.use_cassette "omdb"  do
        result = omdb.media("inception", "", "")

        expect(result["Title"]).to eq("Inception")
      end
    end
  end
end
