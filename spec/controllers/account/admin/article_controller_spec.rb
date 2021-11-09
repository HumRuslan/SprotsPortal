require 'rails_helper'
require 'ckeditor'

RSpec.describe Account::Admin::ArticleController, type: :controller do
  let!(:article) { FactoryBot.attributes_for :article }

  describe "when admin visited article page" do
    login_admin
    it "has get index" do
      get :index
      expect(response).to render_template("index")
    end

    it 'has get new' do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "when admin create article" do
    login_admin
    it "has created article success and redirect to article page" do
      post :create, params: { article: article }
      expect(Article.count).to eq 1
      expect(response).to redirect_to(account_admin_article_index_path)
    end

    it "has created article success and redirect to new page" do
      post :create, params: { article: {
        headline: 'headline'
      } }
      expect(Article.count).to eq 0
      expect(response).to render_template("new")
    end
  end

  describe "when user visited article page" do
    login_user
    it 'has get index' do
      get :index
      expect(response).to have_http_status(:unauthorized)
    end

    it 'has get new' do
      get :new
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
