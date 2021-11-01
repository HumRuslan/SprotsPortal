module ControllerMacros
  def login_user
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      user.confirm
      sign_in user
    end
  end

  def login_admin
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      admin = FactoryBot.create(:user)
      admin.role = 1
      admin.confirm
      sign_in admin
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

  def logout_admin
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      admin = FactoryBot.create(:user)
      admin.role = 1
      admin.confirm
      sign_out admin
    end
  end
end
