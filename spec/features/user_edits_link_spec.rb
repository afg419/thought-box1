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
end
