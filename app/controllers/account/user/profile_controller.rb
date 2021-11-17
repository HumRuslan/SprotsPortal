class Account::User::ProfileController < Account::User::UserApplicationController
  before_action :find_user

  def edit; end

  def update
    if params.user.password.present?

    end
    flash[:notice] = "Profile is saved" if @user.update(user_params)
    render :edit
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation,
                                 :old_password, :avatar)
  end

  def find_user
    @user = User.find(params[:id])
    authorize([:account, :admin, @user])
  end
end
