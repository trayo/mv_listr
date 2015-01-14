require 'rails_helper'

RSpec.describe User, :type => :model do
  describe 'validations' do
    it 'is valid' do
      user = build(:user)
      expect(user).to be_valid
    end
  end

  describe 'auth' do
    it 'can find by auth params' do
      auth_data = {
        'provider' => 'twitter',
        'info' => {'screen_name' => 'omgTrevor',
                   'name' => 'Trevor'},
        'uid' => '10011001'
      }

      user = create(:user, uid: "10011001")
      user_found = User.find_or_create_by_auth(auth_data)

      expect(user_found).to eq(user)
    end
  end
end
