require 'rails_helper'

RSpec.describe OmdbService do

  describe 'validation' do
    it 'has a connection' do
      omdb = OmdbService.new

      expect(omdb.connection.class.to_s).to eq("Faraday::Connection")
    end

    it 'can find a movie' do
      omdb = OmdbService.new

      result = omdb.media("inception", "", "")

      expect(result["Title"]).to eq("Inception")
    end
  end
end
