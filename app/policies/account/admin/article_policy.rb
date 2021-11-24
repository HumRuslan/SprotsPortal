class Account::Admin::ArticlePolicy < BasePolicy
  %w[index? new? create? edit? update? destroy? published? unpublished? show?].each do |action|
    define_method(action) do
      @current_user.admin?
    end
  end
end
