require 'rails_helper'

RSpec.describe Account::Admin::CategoryController, type: :controller do
  let(:category) { FactoryBot.attributes_for :category }
  let!(:category_create) { FactoryBot.create :category }

  describe "when admin visited index page" do
    login_admin
    it "has get index" do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it "has get new" do
      get :new, xhr: true
      expect(response).to have_http_status(:ok)
    end

    it "has get update" do
      get :edit, params: { id: category_create.id }, xhr: true
      expect(response).to have_http_status(:ok)
    end
  end

  describe "when user visited index page" do
    login_user
    it "has get index" do
      get :index
      expect(response).to have_http_status(:unauthorized)
    end

    it "has get new" do
      get :new, xhr: true
      expect(response).to have_http_status(:unauthorized)
    end

    it "has get update" do
      get :edit, params: { id: category_create.id }, xhr: true
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "when admin create new category" do
    login_admin
    it "has create new category" do
      post :create, params: { category: category }, xhr: true
      expect(Category.where(name: category[:name])).to have(1).records
      expect(response).to have_http_status(:ok)
    end

    it "hasn't create new category" do
      post :create, params: { category: { name: "" } }
      expect(flash[:alert]).to be_present
    end
  end

  describe "when admin update new category" do
    login_admin
    it "has update category" do
      post :update, params: { id: category_create.id, category: {
        name: "Some_Text"
      } }, xhr: true
      expect(Category.where(name: "Some_Text")).to have(1).records
      expect(response).to have_http_status(:ok)
    end

    it "hasn't update category" do
      post :update, params: { id: category_create.id, category: { name: "" } }
      expect(flash[:alert]).to be_present
    end
  end

  describe "when admin delete category" do
    login_admin
    it 'has delete category' do
      delete :destroy, params: { id: category_create.id }, xhr: true
      expect(Category.where(id: category_create.id)).to have(0).records
    end

    it 'has category not found' do
      delete :destroy, params: { id: 'not_found' }, xhr: true
      expect(response).to have_http_status(:not_found)
    end
  end
end
