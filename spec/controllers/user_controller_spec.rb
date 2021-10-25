require 'rails_helper'

RSpec.describe UserController, type: :controller do
  describe "GET index" do
    it "assigns @users" do
      user = FactoryBot.create :user
      get :index
      expect(assigns(:users)).to eq([user])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
end
