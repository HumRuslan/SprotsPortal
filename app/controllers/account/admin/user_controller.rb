class Account::Admin::UserController < Account::Admin::AdminApplicationController
  def index
    @users = User.all
    authorize([:account, :admin, @users])
  end
end
