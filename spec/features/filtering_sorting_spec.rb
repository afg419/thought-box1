require 'rails_helper'

RSpec.feature "FilteringSortingSpec", type: :feature do
  scenario "A logged in user can filter links by search query", js: true do
    user = mock_login_user
    create_link(1, user)
    create_link(2, user)
    create_link(3, user)
    create_link(33, user)
    visit links_path

    fill_in "filter-term", with: "3"

    expect(page).to_not have_content("title1")
    expect(page).to_not have_content("title2")
    expect(page).to have_content("title3")
    expect(page).to have_content("title33")
  end

  scenario "A logged in user can sort alphabetically", js: true do
    user = mock_login_user
    link1 = create_link("b", user)
    link2 = create_link("a", user)
    link3 = create_link("c", user)
    visit links_path

    click_on "Sort Alphabetically"

    expect(page.body.index("titlea") < page.body.index("titleb"))
    expect(page.body.index("titleb") < page.body.index("titlec"))
  end

  scenario "A logged in user can filter by read and unread", js: true do
    user = mock_login_user
    link1 = create_link("b", user)
    create_link("a", user)
    create_link("c", user)

    visit links_path
    expect(page).to have_content("titlea")
    expect(page).to have_content("titlec")
    expect(page).to have_content("titleb")

    within("#link-#{link1.id}") do
      click_on "Mark as read"
    end

    click_on "Filter by Read"

    expect(page).to_not have_content("titlea")
    expect(page).to_not have_content("titlec")
    expect(page).to have_content("titleb")
  end
end
