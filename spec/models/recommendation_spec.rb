require 'rails_helper'

RSpec.describe Recommendation, :type => :model do
  describe "validations" do
    it "is invalid if it's missing an attribute" do
      recommendation = build(:recommendation)

      recommendation.title = nil
      expect(recommendation).to_not be_valid

      recommendation.title = ''
      expect(recommendation).to_not be_valid
    end
  end
end
