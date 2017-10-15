require "rails_helper"

RSpec.feature "Signing out signed-in users" do
  before do
    @said = User.create!(email: "said@maadan.me", password: "password")

    visit '/'
    click_link "Sign in"
    fill_in "Email", with: @said.email
    fill_in "Password", with: @said.password
    click_button "Log in"
  end

  scenario do
    visit "/"
    click_link "Sign out"
    expect(page).to have_content("Signed out successfully.")
    expect(page).not_to have_content("Sign out")

  end
end
