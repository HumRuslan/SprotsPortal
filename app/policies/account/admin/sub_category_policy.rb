class Account::Admin::SubCategoryPolicy < BasePolicy
  %w[new? create? edit? update? destroy?].each do |action|
    define_method(action) do
      @current_user.admin?
    end
  end
end
