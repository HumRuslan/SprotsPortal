module ControllerMacros
  def login_user
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      user.confirm
      sign_in user
    end
  end

  def logout_user
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      user.confirm
      sign_out user
    end
  end
end
