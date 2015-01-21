require 'rails_helper'

RSpec.describe Recommendation, :type => :model do
  describe 'validations' do
    it 'is valid' do
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
end
