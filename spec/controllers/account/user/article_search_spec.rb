require 'rails_helper'

RSpec.describe Account::User::HomeController, type: :controller do
  around do |each|
    article
    ArticlesIndex.import!
    each.run
    ArticlesIndex.delete
    ArticlesIndex.create!
  end

  let!(:article) { FactoryBot.create :article, :published }

  describe "when user search article by category" do
    it "has article" do
      get :search, params: {
        search: {
          filters: {
            published: "published",
            category_id: article.team.sub_category.category_id
          }
        }
      }
      expect(assigns(:articles).count).to be > 0
    end

    it "hasn't article" do
      get :search, params: {
        search: {
          filters: {
            published: "published",
            category_id: 9999
          }
        }
      }
      expect(assigns(:articles).count).to eq 0
    end
  end

  describe "when user search article by search params" do
    it "has article" do
      get :search, params: {
        search: {
          filters: {
            published: "published"
          },
          query: article.headline
        }
      }
      expect(assigns(:articles).count).to be > 0
    end

    it "hasn't article" do
      get :search, params: {
        search: {
          filters: {
            published: "published"
          },
          query: "Some_text"
        }
      }
      expect(assigns(:articles).count).to eq 0
    end
  end
end
