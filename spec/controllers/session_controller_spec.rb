require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
  describe 'omniauth' do
    let(:auth_data) do
      { 'provider' => 'twitter',
        'info' => {'name' => 'Alice Smith',
                   'nickname' => 'asmith'},
        'uid' => '123456',
        'extra' => {'raw_info' => {'profile_image_url_https' => 'http://robohash.org/1.png'}}
      }
    end

    it "logs in a new user" do
      @request.env["omniauth.auth"] = {
        'provider' => 'twitter',
        'info' => {'name' => 'Alice Smith',
                   'nickname' => 'asmith'},
        'uid' => '123456',
        'extra' => {'raw_info' => {'profile_image_url_https' => 'http://robohash.org/1.png'}}
      }

      post :create
      user = User.find_by(uid: "123456")

      expect(user.name).to eq("Alice Smith")
    end

    it "logs in an existing user" do
      @request.env["omniauth.auth"] = {
        'provider' => 'twitter',
        'info' => {'name' => 'Bob Jones',
                   'nickname' => 'bjones'},
        'uid' => '654321',
        'extra' => {'raw_info' => {'profile_image_url_https' => 'http://robohash.org/1.png'}}
      }
      user = create(:user, uid: "654321")

      post :create

      expect(User.count).to eq(1)
    end
  end
end
