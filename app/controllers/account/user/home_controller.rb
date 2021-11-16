class Account::User::HomeController < Account::User::UserApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  def index
    @search = ArticleSearch.new(search_params)
    @articles = Article.all.published
  end

  def show
    @article = Article.find(params['id'])
  end

  private

  def search_params
    params[:search].permit(:query) if params[:search].present?
  end
end
