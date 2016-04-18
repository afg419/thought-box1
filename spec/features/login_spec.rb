require 'rails_helper'

RSpec.feature "Login Spec", type: :feature do
  scenario "A user with account can login" do
    User.create(email: "afg419@gmail.com", password: "password")

    visit root_path
    click_on "Login"
    fill_in "user_email", with: "afg419@gmail.com"
    fill_in "user_password", with: "password"
    click_on "Login"
    expect(current_path).to eq links_path
    expect(page).to have_content("Logged in afg419@gmail.com")
  end

  scenario "A user with wrong password cant login" do
    User.create(email: "afg419@gmail.com", password: "password")

    visit login_path
    fill_in "user_email", with: "afg419@gmail.com"
    fill_in "user_password", with: "password1"
    click_on "Login"
    expect(current_path).to eq login_path
    expect(page).to have_content("Incorrect username password combination")
  end
end
