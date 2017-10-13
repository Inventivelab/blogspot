require "rails_helper"

RSpec.feature "Creating Articles" do

  before do
    @said = User.create!(email: "said@maadan.me", password: "password")
    login_as(@said)
  end

  scenario "A user creates a new article" do
    visit "/"

    click_link "New Article"

    fill_in "Title", with: "Post number one"
    fill_in "Body", with: "This is the first post"

    click_button "Create Article"

    expect(Article.last.user).to eq(@said)
    expect(page).to have_content("Article has been created")
    expect(page.current_path).to eq(articles_path)
    expect(page).to have_content("Created by: #{@said.email}")
  end

  scenario "A user fails to create a new article" do
    visit "/"

    click_link "New Article"

    fill_in "Title", with: ""
    fill_in "Body", with: ""

    click_button "Create Article"

    expect(page).to have_content("Article has not been created")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Body can't be blank")
  end
end
