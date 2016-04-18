require 'rails_helper'

RSpec.feature "Logout Spec", type: :feature do
  scenario "A logged in user can log out" do
    User.create(email: "afg419@gmail.com", password: "password")

    login_user

    click_on "Logout"
    expect(current_path).to eq root_path
    expect(page).to have_content("Logged out")
  end
end
