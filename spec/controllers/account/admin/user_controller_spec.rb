require 'rails_helper'

RSpec.describe Account::Admin::UserController, type: :controller do
  let!(:user) { FactoryBot.create :user }

  describe "when user is login and admin" do
    login_admin
    it "has a current_user" do
      expect(subject.current_user).not_to eq(nil)
    end

    it 'has get users' do
      get :users
      expect(response).to render_template("users")
    end
  end

  describe "when user isn't login" do
    logout_admin
    it "has not a current_user" do
      expect(subject.current_user).to eq(nil)
    end

    it 'has not redirect to users' do
      get :users
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "when user login as user" do
    login_user

    it 'has not redirect to users admin page' do
      get :users
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "when admin locked and unlocked user" do
    login_admin
    it 'has user is locked' do
      put :blocked, params: { user_id: user.id }
      expect(User.find_by(id: user.id).access_locked?).to be true
    end

    it 'has user is activated' do
      put :activated, params: { user_id: subject.current_user.id }
      expect(User.find_by(id: user.id).access_locked?).to be false
    end
  end
end
