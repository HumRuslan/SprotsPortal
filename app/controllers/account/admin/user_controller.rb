class Account::Admin::UserController < Account::Admin::AdminApplicationController
  before_action :find_user, only: %i[blocked activated add_admin remove_admin destroy]
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: false).user.confirmed
    @admins = @q.result(distinct: false).admin
    authorize([:account, :admin, @users])
  end

  def destroy
    @user.destroy
    redirect_to account_admin_user_index_url
  end

  def blocked
    @user.lock_access!(send_instructions: false)
    redirect_to account_admin_user_index_url
  end

  def activated
    @user.unlock_access!
    redirect_to account_admin_user_index_url
  end

  def add_admin
    @user.admin!
    redirect_to account_admin_user_index_url
  end

  def remove_admin
    @user.user!
    redirect_to account_admin_user_index_url
  end

  private

  def find_user
    @user = User.find(params['id'])
    authorize([:account, :admin, @user])
  end
end
