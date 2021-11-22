class Account::Admin::CategoryPolicy < BasePolicy
  %w[index? new? create? edit? update? destroy?].each do |action|
    define_method(action) do
      @current_user.admin?
    end
  end
end
