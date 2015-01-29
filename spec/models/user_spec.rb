require 'rails_helper'

RSpec.describe User do
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
end
