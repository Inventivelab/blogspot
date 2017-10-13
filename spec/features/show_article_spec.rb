require "rails_helper"

RSpec.feature "Showing an article" do
  before do
    said = User.create(email: "said@maadan.me", password: "password")
    login_as(said)
    @article = Article.create(title: "The first Post item", body: "This is the first post", user: said)
  end

  scenario "A user shows an article" do
    visit '/'
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
  end
end
