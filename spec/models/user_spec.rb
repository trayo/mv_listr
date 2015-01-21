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
        'info' => {'nickname' => 'omgTrevor',
                   'name' => 'Trevor'},
        'uid' => '10011001',
        'extra' => {'raw_info' => {'profile_image_url_https' => 'http://robohash.org/1.png'}}
      }

      user = create(:user, uid: "10011001")
      user_found = User.find_or_create_by_auth(auth_data)

      expect(user_found).to eq(user)
    end
  end

  describe 'relationships' do
    it 'has a recommendation' do
      recommendation = build(:recommendation, id: 1, title: "Looper")
      user = build(:user, id: 1)

      user.recommendations << recommendation

      expect(user.recommendations.first.title).to eq("Looper")
    end
  end
end
