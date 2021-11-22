require 'rails_helper'

RSpec.describe Account::User::HomeController, type: :controller do
  after do
    ArticlesIndex.delete
    ArticlesIndex.create!
  end

  let!(:article) { FactoryBot.create :article, :published }

  describe "when user search article by category" do
    it "has article" do
      article
      ArticlesIndex.import!
      get :articles_by_category, params: { id: article.team.sub_category.category_id }
      expect(assigns(:articles).count).to be > 0
    end

    it "hasn't article" do
      article
      ArticlesIndex.import!
      get :articles_by_category, params: { id: "not_found" }
      expect(assigns(:articles).count).to eq 0
    end
  end

  describe "when user search article by search params" do
    it "has article" do
      article
      ArticlesIndex.import!
      get :articles_by_category, params: {
        search: article.headline
      }
      expect(assigns(:articles).count).to be > 0
    end

    it "has article with search params" do
      article
      ArticlesIndex.import!
      get :search_articles, params: {
        search: "Some_text"
      }
      expect(assigns(:articles).count).to eq 0
    end
  end
end
