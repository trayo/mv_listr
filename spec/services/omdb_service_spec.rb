require 'rails_helper'

RSpec.describe OmdbService do

  describe 'validation' do
    it 'can find a movie' do
      omdb = OmdbService.new

      VCR.use_cassette "omdb"  do
        result = omdb.media("inception", "", "")

        expect(result["Title"]).to eq("Inception")
      end
    end
  end
end
