require "rails_helper"

RSpec.describe "Articles", type: :request do
  before do
    @said = User.create(email: "said@maadan.me", password: "password")
    @fola = User.create(email: "fola@maadan.me", password: "password")
    @article = Article.create!(title: "The first Post item", body: "This is the first post", user: @said)
  end

    # Edit Authorization
  describe "GET /article/:id/edit" do
    context 'with not-signed in user' do
      before {get "/articles/#{@article.id}/edit"}
      it "redirect to the signin page" do
        expect(response.status).to eq 302
        flash_message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user who is non-owner' do
      before do
        login_as(@fola)
        get "/articles/#{@article.id}/edit"
      end
      it "redirects to the home page" do
        expect(response.status).to eq 302
        flash_message = "You can only edit your own article."
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user as owner successful edit' do
      before do
        login_as(@said)
        get "/articles/#{@article.id}/edit"
      end
      it "successfully edits article" do
        expect(response.status).to eq 200
      end
    end
  end

  # Delete Authorization
  describe "GET /article/:id" do
    context 'with not-signed in user' do
      before {get "/articles/#{@article.id}"}
      it "redirect to the signin page" do
        expect(response.status).to eq 302
        flash_message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user who is non-owner' do
      before do
        login_as(@fola)
        get "/articles/#{@article.id}"
      end
      it "redirects to the home page" do
        expect(response.status).to eq 302
        flash_message = "You can only delete your own article."
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user as owner successful delete' do
      before do
        login_as(@said)
        get "/articles/#{@article.id}"
      end
      it "successfully delete article" do
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET /articles/:id' do
    context 'with existing article' do
      before {get "/articles/#{@article.id}"}
      it "handles existing article" do
        expect(response.status).to eq 200
      end
    end
    context 'with non-existing article' do
      before{get "/articles/xxx"}
      it "handles non-existing article" do
        expect(response.status).to eq 302
        flash_message = "The article you are looking for could not be found"
        expect(flash[:alert]).to eq flash_message
      end
    end
  end
end
