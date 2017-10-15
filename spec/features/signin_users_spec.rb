require "rails_helper"

RSpec.feature "Users Signin" do
  before do
    @said = User.create!(email: "said@maadan.me", password: "password")
  end

  scenario "with valid credentials" do
    visit "/"

    click_link "Sign in"
    fill_in "Email", with: @said.email
    fill_in "Password", with: @said.password
    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("Signed in as #{@said.email}")
    expect(page).not_to have_link("Sign in")
    expect(page).not_to have_link("Sign up")
  end
end
