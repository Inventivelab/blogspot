require 'rails_helper'

RSpec.feature "Editing an article" do

  before do
    said = User.create(email: "said@maadan.me", password: "password")
    login_as(said)
    @article = Article.create(title: "Title One", body: "Body of article one", user: said)
  end

  scenario "A user updates an article" do
    visit "/"

    click_link @article.title
    click_link "Edit Article"

    fill_in "Title", with: "Title One"
    fill_in "Body", with: "Body of article one"
    click_button "Update Article"

    expect(page).to have_content("Article has been updated")
    expect(page.current_path).to eq(article_path(@article))
  end

  scenario "A user fails to update an article" do
    visit "/"

    click_link @article.title
    click_link "Edit Article"

    fill_in "Title", with: ""
    fill_in "Body", with: ""
    click_button "Update Article"

    expect(page).to have_content("Article has not been updated")
    expect(page.current_path).to eq(article_path(@article))
  end
end
