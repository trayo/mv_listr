require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
  describe 'omniauth' do
    let(:auth_data) do
      { 'provider' => 'twitter',
        'info' => {'name' => 'Alice Smith'},
        'uid' => 'abc123'
      }
    end

    it "logs in a new user" do
      @request.env["omniauth.auth"] = {
        'provider' => 'twitter',
        'info' => {'name' => 'Alice Smith'},
        'uid' => 'abc123'
      }

      post :create
      user = User.find_by(uid: "abc123")

      expect(user.name).to eq("Alice Smith")
    end

    it "logs in an existing user" do
      @request.env["omniauth.auth"] = {
        'provider' => 'twitter',
        'info' => {'name' => 'Bob Jones'},
        'uid' => 'xyz456'
      }
      user = create(:user, uid: "xyz456")

      post :create

      expect(User.count).to eq(1)
    end
  end
end
