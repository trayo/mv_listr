require 'rails_helper'

RSpec.describe "Searching for media" do

  feature "finding a movie" do
    scenario "a user can't go to recommendations page without logging in" do
      visit recommendations_path

      expect(page).to have_content("You must be logged in")
    end

    scenario "a user goes to their recommendations page" do
      sign_in_via_twitter

      expect(page).to have_content("No recommendations found.")
    end

    scenario "they can find a new movie" do
      sign_in_via_twitter

      search_for_the_movie("Looper")

      expect(page).to have_content("Looper (2012)")
    end

    scenario "they can't send an empty search" do
      sign_in_via_twitter

      first('input[type="submit"]').click

      expect(page).to have_content("Search was empty.")
    end

    scenario "it tells them when a movie doesnt exist" do
      sign_in_via_twitter

      search_for_the_movie("asddfafda")

      expect(page).to have_content("Movie not found!")
    end

    scenario "searching for the same movie doesn't get added twice" do
      sign_in_via_twitter

      search_for_the_movie("inception")
      search_for_the_movie("inception")

      expect(page).to have_content("That movie has already been added.")
    end
  end

  feature "marking movies as watched" do
    scenario "can't go to the watched page without logging in" do
      visit recommendations_watched_path

      expect(page).to have_content("You must be logged in")
    end

    scenario "a user can mark a movie as watched and unwatched" do
      sign_in_via_twitter
      search_for_the_movie("Looper")

      click_button "Mark as watched"
      expect(page).to have_content("No recommendations found.")

      visit recommendations_watched_path
      expect(page).to have_content("Looper (2012)")

      click_button "Mark as unwatched"
      expect(page).to have_content("No watched recommendations found.")

      visit recommendations_path
      expect(page).to have_content("Looper (2012)")
    end
  end

  feature "deleting movies" do
    scenario "a user can delete a movie from their current recommendations" do
      sign_in_via_twitter

      search_for_the_movie("Looper")

      click_button "Delete"
      expect(page).to have_content("No recommendations found.")
      expect(page).to have_content("Movie deleted.")
    end

    scenario "a user can delete a movie from their watched recommendations" do
      sign_in_via_twitter

      search_for_the_movie("Looper")
      click_button "Mark as watched"
      visit recommendations_watched_path

      click_button "Delete"
      expect(page).to have_content("No watched recommendations found.")
      expect(page).to have_content("Movie deleted.")
    end
  end

  def sign_in_via_twitter
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(
      "provider" => "twitter",
      "info"     => { "name" => "trevor",
      "nickname" => "trevor_is_da_coolest" },
      "uid"      => "123456",
      "extra"    => { "raw_info" =>
                    { "profile_image_url_https" =>
                      "http://robohash.org/1.png" } }
    )

    visit root_path
    first(".active").click_link("Login with Twitter")
  end

  def search_for_the_movie(movie)
    VCR.use_cassette "searching for #{movie}" do
      fill_in "search_1", with: movie
      first('input[type="submit"]').click
    end
  end
end
