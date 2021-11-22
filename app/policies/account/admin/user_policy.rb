class Account::Admin::UserPolicy < BasePolicy
  %w[index? edit? update? destroy? blocked? activated? add_admin? remove_admin?].each do |action|
    define_method(action) do
      @current_user.admin?
    end
  end

  %w[edit? update?].each do |action|
    define_method(action) do
      @user.id == @current_user.id
    end
  end
end
