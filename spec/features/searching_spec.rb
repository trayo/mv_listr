require 'rails_helper'

RSpec.describe "Searching for media" do

  before :each do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = nil
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      'provider' => 'twitter',
      'info' => {'name' => 'trevor',
      'nickname' => 'trevor_is_da_coolest'},
      'uid' => '123456',
      'extra' => {'raw_info' => {'profile_image_url_https' => 'http://robohash.org/1.png'}}
    })
  end

  feature 'searching for a movie' do
    scenario 'can go to the recommendation page' do
      visit recommendations_path

      expect(current_path).to eq(root_path)
    end
  end
end
