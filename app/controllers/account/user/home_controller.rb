class Account::User::HomeController < Account::User::UserApplicationController
  skip_before_action :authenticate_user!, only: %i[index show search]

  def index
    search = search_params
    search[:filters] = { published: "published" }
    @search = ArticleSearch.new(search)
    @articles = @search.result.objects
  end

  def show
    @article = Article.find(params['id'])
  end

  def search
    @search = ArticleSearch.new(search_params)
    @articles = @search.result.objects
    render :articles
  end

  private

  def search_params
    params.permit(search: {})[:search] || {}
  end
end
