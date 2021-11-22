require 'rails_helper'

RSpec.describe Account::Admin::TeamController, type: :controller do
  let(:team) { FactoryBot.attributes_for :team }
  let!(:team_create) { FactoryBot.create :team }

  describe "when admin visited index page" do
    login_admin

    it "has get new" do
      get :new, params: {
        category_id: team_create.sub_category.category_id,
        sub_category_id: team_create.sub_category_id
      }, xhr: true
      expect(response).to have_http_status(:ok)
    end

    it "has get update" do
      get :edit, params: {
        category_id: team_create.sub_category.category_id,
        sub_category_id: team_create.sub_category_id,
        id: team_create.id
      }, xhr: true
      expect(response).to have_http_status(:ok)
    end
  end

  describe "when user visited index page" do
    it "has get new" do
      get :new, params: {
        category_id: team_create.sub_category.category_id,
        sub_category_id: team_create.sub_category_id
      }, xhr: true
      expect(response).to have_http_status(:unauthorized)
    end

    it "has get update" do
      get :edit, params: {
        category_id: team_create.sub_category.category_id,
        sub_category_id: team_create.sub_category_id,
        id: team_create.id
      }, xhr: true
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "when admin create new team" do
    login_admin
    it "has create new subcategory" do
      post :create, params: {
        category_id: team_create.sub_category.category_id,
        sub_category_id: team_create.sub_category_id,
        team: {
          name: team[:name],
          sub_category_id: team_create.sub_category_id
        }
      }, xhr: true
      expect(Team.where(name: team[:name])).to have(1).records
      expect(response).to have_http_status(:ok)
    end

    it "hasn't create new team" do
      post :create, params: {
        category_id: team_create.sub_category.category_id,
        sub_category_id: team_create.sub_category_id,
        team: { name: "" }
      }
      expect(flash[:alert]).to be_present
    end
  end

  describe "when admin update team" do
    login_admin
    it "has update new subcategory" do
      post :update, params: {
        id: team_create.id,
        category_id: team_create.sub_category.category_id,
        sub_category_id: team_create.sub_category_id,
        team: {
          name: team[:name],
          sub_category_id: team_create.sub_category_id
        }
      }, xhr: true
      expect(Team.where(name: team[:name])).to have(1).records
      expect(response).to have_http_status(:ok)
    end

    it "hasn't update subcategory" do
      post :update, params: {
        id: team_create.id,
        category_id: team_create.sub_category.category_id,
        sub_category_id: team_create.sub_category_id,
        team: {
          name: "",
          sub_category_id: team_create.sub_category_id
        }
      }, xhr: true
      expect(flash[:alert]).to be_present
    end
  end

  describe "when admin delete team" do
    login_admin
    it 'has delete team' do
      delete :destroy, params: {
        id: team_create.id,
        category_id: team_create.sub_category.category_id,
        sub_category_id: team_create.sub_category_id
      }, xhr: true
      expect(Team.where(id: team_create.id)).to have(0).records
    end

    it 'has team not found' do
      delete :destroy, params: {
        category_id: team_create.sub_category.category_id,
        sub_category_id: team_create.sub_category_id,
        id: 'not_found'
      }, xhr: true
      expect(response).to have_http_status(:not_found)
    end
  end
end
