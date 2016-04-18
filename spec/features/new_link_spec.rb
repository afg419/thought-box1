require 'rails_helper'

RSpec.feature "NewLink", type: :feature do
  scenario "A logged in user can create a new link", js: true do
    expect(Link.count).to eq 0

    mock_login_user
    visit links_path

    fill_in "link_url", with: "http://www.google.com"
    fill_in "link_title", with: "Google"
    click_on "Create new link"

    expect(current_path).to eq links_path
    expect(page).to have_content("Created new link!")
    expect(page).to have_content("http://www.google.com")
    expect(page).to have_content("Google")
    expect(page).to have_content("Read: false")
    expect(Link.count).to eq 1
  end

  scenario "A logged in user can see all old links", js: true do
    user = mock_login_user
    create_link(1, user)
    create_link(2, user)
    visit links_path

    expect(page).to have_content("title1")
    expect(page).to have_content("title2")
  end

  scenario "A logged in user doesnt see other links", js: true do
    user = mock_login_user
    create_link(1, user)
    create_link(2, user)

    user2 = User.create(email: "jobob", password:"password")
    create_link(3, user2)

    visit links_path

    expect(page).to have_content("title1")
    expect(page).to have_content("title2")
    expect(page).to_not have_content("title3")
  end
end
