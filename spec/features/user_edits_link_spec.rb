require 'rails_helper'

RSpec.feature "EditLink", type: :feature do
  scenario "A logged in user can make link as read and unread", js: true do
    user = mock_login_user
    create_link(1, user)
    visit links_path

    click_on "Mark as read"

    expect(current_path).to eq links_path
    expect(page).to have_content("Read: true")
    expect(page).to have_content("Mark as unread")

    click_on "Mark as unread"

    expect(current_path).to eq links_path
    expect(page).to have_content("Read: false")
    expect(page).to have_content("Mark as read")
  end

  scenario "A logged in user can change title and url", js: true do
    user = mock_login_user
    create_link(1, user)
    visit links_path

    expect(page).to have_content("title1")
    expect(page).to have_content("http://www.google1.com")

    click_on "Edit"
    fill_in "title", with: "title2"
    fill_in "url", with: "http://www.google2.com"
    click_on "Update link"

    expect(page).to have_content("title2")
    expect(page).to have_content("http://www.google2.com")
  end

  scenario "A logged in user cant change anything with invalid url", js: true do
    user = mock_login_user
    create_link(1, user)
    visit links_path

    expect(page).to have_content("title1")
    expect(page).to have_content("http://www.google1.com")

    click_on "Edit"
    fill_in "title", with: "title2"
    fill_in "url", with: "blackmomba"
    click_on "Update link"

    expect(page).to_not have_content("title2")
    expect(page).to_not have_content("blacmomba")
    expect(page).to have_content("blackmomba is an invalid url!")
  end

end
