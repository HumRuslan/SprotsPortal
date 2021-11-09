require 'rails_helper'

RSpec.describe Account::User::HomeController, type: :controller do
  let!(:article) { FactoryBot.create :article }

  describe "when user visited index page" do
    it "has get index" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "when user preview article" do
    it "has get show" do
      get :show, params: { id: article.id }
      expect(response).to render_template("show")
    end
  end
end
