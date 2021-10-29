require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "when user is login" do
    login_user
    it 'has get index' do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "when user isn't login" do
    it 'has not redirect to index' do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
