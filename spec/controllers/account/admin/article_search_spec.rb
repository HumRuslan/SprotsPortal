require 'rails_helper'

RSpec.describe Account::Admin::ArticleController, type: :controller do
  let!(:article) { FactoryBot.create :article }

  describe "when use search article" do
    login_admin
    it 'has articles without search params' do
      article
      ArticlesIndex.import!
      get :index
      expect(assigns(:articles).count).to be > 0
    end

    it "hasn't articles with search params" do
      article
      ArticlesIndex.import!
      get :index, params: {
        search: {
          query: "Some_Text"
        }
      }
      expect(assigns(:articles).count).to eq 0
    end
  end

  describe "when use filtered article" do
    login_admin
    it 'has articles' do
      article
      ArticlesIndex.import!
      get :index, params: {
        search: {
          filters: {
            published: "unpublished"
          }
        }
      }
      expect(assigns(:articles).count).to be > 0
    end

    it "hasn't articles with filtered params" do
      article
      ArticlesIndex.import!
      get :index, params: {
        search: {
          filters: {
            published: "published"
          }
        }
      }
      expect(assigns(:articles).count).to eq 0
    end
  end
end
