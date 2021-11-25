require 'rails_helper'

RSpec.describe Auth::OmniauthCallbacksController, type: :controller do
  describe "When user login use google" do
    stub_omniauth
    it "has add user" do
      get :google_oauth2
      expect(User.where(first_name: "John Smith")).to have(1).records
    end
  end
end
