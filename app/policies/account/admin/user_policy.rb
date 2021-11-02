class Account::Admin::UserPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def index?
    @current_user.admin?
  end

  def blocked?
    @current_user.admin?
  end

  def activated?
    @current_user.admin?
  end

  def add_admin?
    @current_user.admin?
  end

  def remove_admin?
    @current_user.admin?
  end
end
