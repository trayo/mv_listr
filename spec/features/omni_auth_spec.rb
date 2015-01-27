require 'rails_helper'

RSpec.describe "Twitter and OmniAuth" do

  feature 'User OmniAuth' do
    before :each do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:twitter] = nil
    end

    scenario 'OmniAuth is in test mode' do
      expect(OmniAuth.config.test_mode).to eq(true)
    end

    scenario 'can mock twitter' do
      OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
        'provider' => 'twitter',
        'info' => {'name' => 'trevor',
        'nickname' => 'trevor_is_da_coolest'},
        'uid' => '123456',
        'extra' => {'raw_info' => {'profile_image_url_https' => 'http://robohash.org/1.png'}}
      })

      expect(OmniAuth.config.mock_auth[:twitter].info.name).to eq("trevor")
    end

    scenario 'can log in and log out' do
      OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
        'provider' => 'twitter',
        'info' => {'name' => 'trevor',
        'nickname' => 'trevor_is_da_coolest'},
        'uid' => '123456',
        'extra' => {'raw_info' => {'profile_image_url_https' => 'http://robohash.org/1.png'}}
      })

      visit root_path
      first('.active').click_link("Login with Twitter")

      expect(current_path).to eq(recommendations_path)

      first('.active').click_link "Sign out"
      expect(current_path).to eq(root_path)
    end

    scenario "can't visit the recommendation page without logging in" do
      visit recommendations_path

      expect(page).to have_content("You must be logged in to access that page.")
    end
  end
end
