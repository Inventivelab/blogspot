require "rails_helper"

RSpec.feature "Showing an article" do
  before do
    @said = User.create(email: "said@maadan.me", password: "password")
    @fola = User.create(email: "fola@maadan.me", password: "password")

    @article = Article.create(title: "The first Post item", body: "This is the first post", user: @said)
  end

  scenario "to non-signed in user hide the Edit and Delete buttons" do
    visit '/'
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))

    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delet Article")
  end

  scenario "to non-owner hide the Edit and Delete buttons" do
    login_as(@fola)
    visit '/'
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))

    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delet Article")
  end
end
