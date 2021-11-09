class Account::User::HomeController < Account::User::UserApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  def index
    @articles = Article.all.published
  end

  def show
    @article = Article.find_by(id: params['id'])
  end
end
