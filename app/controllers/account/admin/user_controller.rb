class Account::Admin::UserController < Account::Admin::AdminApplicationController
  def users
    @users = User.where.not(confirmed_at: nil)
    @admins = User.where(role: 1)
    @count_users = @users.size
    @count_admins = @admins.size
    authorize([:account, :admin, @users])
  end

  def blocked
    user = User.find_by(id: params['user_id'])
    authorize([:account, :admin, user])
    user.lock_access!(send_instructions: false)
    redirect_to account_admin_users_url and return
  end

  def activated
    user = User.find_by(id: params['user_id'])
    authorize([:account, :admin, user])
    authorize([:account, :admin, user])
    user.unlock_access!
    redirect_to account_admin_users_url and return
  end
end
