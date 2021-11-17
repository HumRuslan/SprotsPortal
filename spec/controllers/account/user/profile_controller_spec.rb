require 'rails_helper'

RSpec.describe Account::User::ProfileController, type: :controller do
  let!(:user) { FactoryBot.create :user, :confirm }

  describe "when user update profile" do
    it "has profile page" do
      sign_in user
      get :edit, params: { id: user.id }
      expect(response).to have_http_status(:ok)
    end

    it 'has change profile' do
      sign_in user
      put :update, params: {
        id: user.id,
        user: {
          first_name: "New name"
        }
      }
      expect(User.find_by(id: user.id).first_name).to eq("New name")
    end

    it 'has change password' do
      sign_in user
      put :update, params: {
        id: user.id,
        user: {
          current_password: user.password,
          password: "new password",
          password_confirmation: "new password"
        }
      }
      expect(User.find_by(id: user.id).valid_password?("new password")).to be true
    end

    it "hasn't change password" do
      sign_in user
      put :update, params: {
        id: user.id,
        user: {
          current_password: '111',
          password: "new password",
          password_confirmation: "new password"
        }
      }
      expect(User.find_by(id: user.id).valid_password?("new password")).to be false
    end
  end
end
