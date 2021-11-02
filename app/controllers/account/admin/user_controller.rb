class Account::Admin::UserController < Account::Admin::AdminApplicationController
  before_action :find_user, only: %i[blocked activated]

  def index
    @users = User.user.confirmed
    @admins = User.admin
    authorize([:account, :admin, @users])
  end

  def blocked
    @user.lock_access!(send_instructions: false)
    redirect_to account_admin_index_url
  end

  def activated
    @user.unlock_access!
    redirect_to account_admin_index_url
  end

  private

  def find_user
    @user = User.find_by(id: params['user_id'])
    authorize([:account, :admin, @user])
  end
end
