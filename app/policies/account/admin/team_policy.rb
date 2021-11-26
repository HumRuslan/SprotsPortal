class Account::Admin::TeamPolicy < BasePolicy
  %w[new? create? edit? update? destroy? upload_csv? download_csv?].each do |action|
    define_method(action) do
      @current_user.admin?
    end
  end
end
