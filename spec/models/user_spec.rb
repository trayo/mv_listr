require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) { create(:user) }

  describe 'validations' do
    it 'is valid' do
      expect(user).to be_valid
    end

    it 'invalid without a name' do
      user.name = ""
      expect(user).to_not be_valid

      user.name = nil
      expect(user).to_not be_valid
    end
  end
end
