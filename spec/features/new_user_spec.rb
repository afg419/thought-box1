require 'rails_helper'

RSpec.feature "NewUserAccount", type: :feature do
  # before(:each) do
  #
  # end

  scenario "A user can create new account" do
    expect(User.count).to eq 0

    visit root_path
    click_on "Sign Up"
    fill_in "user_email", with: "afg419@gmail.com"
    fill_in "user_password", with: "password"
    click_on "Create new account"
    expect(current_path).to eq links_path
    expect(page).to have_content("Created account and logged in afg419@gmail.com")
    expect(User.count).to eq 1
  end
end
