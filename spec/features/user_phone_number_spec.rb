require "rails_helper"

RSpec.describe "User Phone Number" do

  feature "can add a phone number to their profile" do
    scenario "can visit settings page" do
      visit "/"
      save_and_open_page


      click_link "Add a phone number"

      fill_in "phone number", with: "555-555-5555"
      click_link "submit"

      expect(user.phone_number).to eq("+15555555555")
    end
  end

  feature "can edit a phone number on their profile" do
    pending 'Not implemented'
  end

  feature "can delete a phone number on their profile" do
    pending 'Not implemented'
  end
end
