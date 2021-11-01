require 'rails_helper'

RSpec.describe Auth::SessionsController, type: :controller do
  describe 'When user is login as admin' do
    login_admin
    it 'has role admin' do
      post :create, params: { user: { email: subject.current_user.email,
                                      password: subject.current_user.password } }
      expect(subject.current_user.admin?).to be true
    end

    it 'has to redirect to admin page' do
      post :create, params: { user: { email: subject.current_user.email,
                                      password: subject.current_user.password } }

      expect(response).to redirect_to(account_admin_root_path)
    end
  end

  describe 'When user is login as user' do
    login_user
    it 'has role user' do
      post :create, params: { user: { email: subject.current_user.email,
                                      password: subject.current_user.password } }
      expect(subject.current_user.admin?).to be false
    end

    it 'has to redirect to admin page' do
      post :create, params: { user: { email: subject.current_user.email,
                                      password: subject.current_user.password } }

      expect(response).to redirect_to(root_path)
    end
  end
end
