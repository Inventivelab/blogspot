require "rails_helper"

RSpec.describe "Comments", type: :request do
  before do
    @said = User.create(email: "said@maadan.me", password: "password")
    @fola = User.create(email: "fola@maadan.me", password: "password")
    @article = Article.create!(title: "The first Post item", body: "This is the first post", user: @said)
  end

  describe "POST /articles/:id/comments" do
    context "with a non signed-in user" do
      before do
        post "/articles/#{@article.id}/comments", params: { comment: { body: "Awesome Post"}}
      end

      it "redirect user to the signin page" do
        flash_message = "Please signin or sign out first"
        expect(response).to redirect_to(new_user_session_path)
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq flash_message
      end
    end

    context "with a logged in user" do
      before do
        login_as(@fola)
        post "/articles/#{@article.id}/comments", params: { comment: { body: "Awesome Post"}}
      end

      it "create the comment successfully" do
        flash_message = "Comment has been created"
        expect(response).to redirect_to(article_path(@article.id))
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq flash_message
      end
    end
  end
end
