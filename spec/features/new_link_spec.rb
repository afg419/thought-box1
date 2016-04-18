require 'rails_helper'

RSpec.feature "NewLink", type: :feature do
  scenario "A logged in user can create a new link" do
    expect(Link.count).to eq 0

    mock_login_user
    visit links_path

    fill_in "link_url", with: "google.com"
    fill_in "link_title", with: "Google"
    click_on "Create new link"

    expect(current_path).to eq links_path
    expect(page).to have_content("Created new link!")
    expect(page).to have_content("google.com")
    expect(page).to have_content("Google")
    expect(page).to have_content("Read: false")
    expect(Link.count).to eq 1
  end

  scenario "A logged in user can see all old links" do
    expect(Link.count).to eq 0

    mock_login_user
    visit links_path

    fill_in "link_url", with: "google.com"
    fill_in "link_title", with: "Google"
    click_on "Create new link"

    expect(current_path).to eq links_path
    expect(page).to have_content("Created new link!")
    expect(page).to have_content("google.com")
    expect(page).to have_content("Google")
    expect(page).to have_content("Read: false")
    expect(Link.count).to eq 1
  end
end
