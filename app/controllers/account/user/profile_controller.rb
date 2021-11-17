class Account::User::ProfileController < Account::User::UserApplicationController
  before_action :find_user

  def edit; end

  def update
    if user_params.key?(:current_password)
      flash[:notice] = "Profile is saved" if @user.update_with_password(user_params)
    elsif @user.update(user_params)
      flash[:notice] = "Profile is saved"
    end
    render :edit
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation,
                                 :current_password, :avatar)
  end

  def find_user
    @user = User.find(params[:id])
    authorize([:account, :admin, @user])
  end
end
