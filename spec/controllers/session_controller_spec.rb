require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
  describe 'omniauth' do

    it "logs in a new user" do
      @request.env["omniauth.auth"] = auth_data

      post :create
      user = User.find_by(uid: "123456")

      expect(user.name).to eq("Alice Smith")
    end

    it "logs in an existing user" do
      @request.env["omniauth.auth"] = auth_data

      user = create(:user, uid: "123456")

      post :create

      expect(User.count).to eq(1)
      expect(User.first.uid).to eq("123456")
    end
  end

  describe "development user" do
    it "logs in a user" do
      user = create(:user, name: "Bart Simpson", uid: "1")

      post :create, "uid" => user.uid

      expect(session["user_id"]).to eq User.last.id
    end
  end

  def auth_data
    {
      'provider' => 'twitter',
      'info' =>
        {
          'name' => 'Alice Smith',
          'nickname' => 'asmith'
        },
      'uid' => '123456',
      'extra' =>
        {
          'raw_info' =>
            { 'profile_image_url_https' => 'http://robohash.org/1.png' }
        }
    }
  end
end
