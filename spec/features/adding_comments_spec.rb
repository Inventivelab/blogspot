require "rails_helper"

RSpec.feature "Adding reviews to Article" do
  before do
    @said = User.create(email: "said@maadan.me", password: "password")
    @fola = User.create(email: "fola@maadan.me", password: "password")

    @article = Article.create(title: "The first Post item", body: "This is the first post", user: @said)
  end

  scenario "permits a signed in user to write a review" do
    login_as(@fola)
    visit "/"
    click_link @article.title
    fill_in "New Comment", with: "Awesome Post"
    click_button "Add Comment"

    expect(page).to have_comment("Comment has been created")
    expect(page).to have_comment("Awesome Post")
    expect(current_path).to eq(article_path(@article.id))
  end
end
