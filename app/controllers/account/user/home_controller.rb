class Account::User::HomeController < Account::User::UserApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  def index
    @articles = Article.all.published
    @articles_search = @search.search.load(only: 'article.published').objects.select(&:published?)
  end

  def show
    @article = Article.find(params['id'])
  end
end
