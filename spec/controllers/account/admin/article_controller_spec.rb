require 'rails_helper'

RSpec.describe Account::Admin::ArticleController, type: :controller do
  let!(:article) { FactoryBot.attributes_for :article }
  let(:article_create) { FactoryBot.create :article }

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

    it "hes get edit" do
      get :edit, params: { id: article_create.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "when admin create article" do
    login_admin
    it "has created article success and redirect to article page" do
      article[:team_id] = article_create[:team_id]
      post :create, params: { article: article }
      expect(Article.where(headline: article[:headline])).to have(1).records
      expect(response).to redirect_to(account_admin_article_index_path)
    end

    it "has created article failed and redirect to new page" do
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

    it "hes get edit" do
      get :edit, params: { id: article_create.id }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "when admin change status article" do
    login_admin
    it "has changed status article by published" do
      put :published, params: { id: article_create.id }
      expect(Article.find_by(id: article_create.id).published?).to be true
    end

    it "has changed status article by unpublished" do
      put :unpublished, params: { id: article_create.id }
      expect(Article.find_by(id: article_create.id).unpublished?).to be true
    end

    it 'has article not found' do
      put :published, params: { id: 'not_found' }
      expect(response).to have_http_status(:not_found)
      put :unpublished, params: { id: 'not_found' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "when admin delete article" do
    login_admin
    it "has article is deleted" do
      delete :destroy, params: { id: article_create.id }
      expect(Article.find_by(id: article_create.id)).to eq(nil)
    end

    it 'has article not found' do
      delete :destroy, params: { id: 'not_found' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "when admin update article" do
    login_admin

    it "has article is update" do
      put :update, params: {
        id: article_create.id,
        article: {
          headline: "headline"
        }
      }
      expect(Article.where(headline: "headline")).to have(1).records
    end

    it "hasn't article is update" do
      put :update, params: {
        id: article_create.id,
        article: {
          headline: ""
        }
      }
      expect(response).to render_template("new")
    end
  end
end
