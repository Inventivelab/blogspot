require "rails_helper"

RSpec.feature "Listing Article" do
  before do
    @article1 = Article.create(title: "The first Post item", body: "This is the first post")
    @article2 = Article.create(title: "The first Post item1", body: "This is the second post")
  end
  scenario " A user lists all articles" do
    visit "/"

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)

    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
  end
end
