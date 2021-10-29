require 'rails_helper'

RSpec.describe Auth::RegistrationsController, type: :controller do
  before do
    request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe 'when create user' do
    it 'has create user success and redirect to login' do
      post :create, params: { user: { first_name: "User",
                                      last_name: "User",
                                      email: "user1@example.org",
                                      password: "password",
                                      password_confirmation: "password" } }
      expect(User.count).to eq 1
      expect(response).to redirect_to(new_user_session_path)
    end

    it "hasn't create user success and redirect to new user" do
      post :create, params: {}
      expect(User.count).to eq 0
      expect(response).to render_template("new")
    end
  end
end
