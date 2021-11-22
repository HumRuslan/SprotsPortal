require 'rails_helper'

RSpec.describe Account::Admin::ArticleController, type: :controller do
  around do |each|
    article
    ArticlesIndex.import!
    each.run
    ArticlesIndex.delete
    ArticlesIndex.create!
  end

  let!(:article) { FactoryBot.create :article }

  describe "when use search article" do
    login_admin
    it 'has articles without search params' do
      get :index
      expect(assigns(:articles).count).to be > 0
    end

    it "hasn't articles with search params" do
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
