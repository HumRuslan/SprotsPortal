require 'rails_helper'

RSpec.describe UserController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  describe "when user is login" do
    login_user
    it "has a current_user" do
      expect(subject.current_user).not_to eq(nil)
    end

    it 'has get index' do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "when user isn't login" do
    logout_user
    it "has not a current_user" do
      expect(subject.current_user).to eq(nil)
    end

    it 'has not redirect to index' do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
