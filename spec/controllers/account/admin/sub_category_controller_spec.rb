require 'rails_helper'

RSpec.describe Account::Admin::SubCategoryController, type: :controller do
  let(:sub_category) { FactoryBot.attributes_for :sub_category }
  let!(:sub_category_create) { FactoryBot.create :sub_category }

  describe "when admin visited index page" do
    login_admin
    it "has get new" do
      get :new, params: { category_id: sub_category_create.category_id }, xhr: true
      expect(response).to have_http_status(:ok)
    end

    it "has get update" do
      get :edit, params: {
        category_id: sub_category_create.category_id,
        id: sub_category_create.id
      }, xhr: true
      expect(response).to have_http_status(:ok)
    end
  end

  describe "when user visited index page" do
    it "has get new" do
      get :new, params: { category_id: sub_category_create.category_id }, xhr: true
      expect(response).to have_http_status(:unauthorized)
    end

    it "has get update" do
      get :edit, params: {
        category_id: sub_category_create.category_id,
        id: sub_category_create.id
      }, xhr: true
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "when admin create new subcategory" do
    login_admin
    it "has create new subcategory" do
      post :create, params: {
        category_id: sub_category_create.category_id,
        sub_category: {
          name: sub_category[:name],
          category_id: sub_category_create.category_id
        }
      }, xhr: true
      expect(SubCategory.where(name: sub_category[:name])).to have(1).records
      expect(response).to have_http_status(:ok)
    end

    it "hasn't create new subcategory" do
      post :create, params: {
        category_id: sub_category_create.category_id,
        sub_category: { name: "" }
      }
      expect(flash[:alert]).to be_present
    end
  end

  describe "when admin update subcategory" do
    login_admin
    it "has update subcategory" do
      post :update, params: {
        id: sub_category_create.id,
        category_id: sub_category_create.category_id,
        sub_category: {
          name: "SOME_NAME",
          category_id: sub_category_create.category_id
        }
      }, xhr: true
      expect(SubCategory.where(name: "SOME_NAME")).to have(1).records
      expect(response).to have_http_status(:ok)
    end

    it "hasn't update subcategory" do
      post :update, params: {
        id: sub_category_create.id,
        category_id: sub_category_create.category_id,
        sub_category: {
          name: "",
          category_id: sub_category_create.category_id
        }
      }, xhr: true
      expect(flash[:alert]).to be_present
    end
  end

  describe "when admin delete subcategory" do
    login_admin
    it 'has delete category' do
      delete :destroy, params: {
        id: sub_category_create.id,
        category_id: sub_category_create.category_id
      }, xhr: true
      expect(SubCategory.where(id: sub_category_create.id)).to have(0).records
    end

    it 'has subcategory not found' do
      delete :destroy, params: {
        category_id: sub_category_create.category_id,
        id: 'not_found'
      }, xhr: true
      expect(response).to have_http_status(:not_found)
    end
  end
end
