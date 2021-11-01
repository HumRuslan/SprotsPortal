require 'rails_helper'

RSpec.describe Account::Admin::UserController, type: :controller do
  describe "when user is login and admin" do
    login_admin
    it "has a current_user" do
      expect(subject.current_user).not_to eq(nil)
    end

    it 'has get index' do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "when user isn't login" do
    logout_admin
    it "has not a current_user" do
      expect(subject.current_user).to eq(nil)
    end

    it 'has not redirect to index' do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "when user login as user" do
    login_user

    it 'has not redirect to index admin page' do
      get :index
      expect(response).to redirect_to(root_path)
    end
  end
end
