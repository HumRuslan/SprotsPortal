class Account::User::HomeController < Account::User::UserApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  def index
    search = search_params
    search[:filters] = { published: "published" }
    @search = ArticleSearch.new(search)
    @articles = @search.result.objects
  end

  def show
    @article = Article.find(params['id'])
  end

  def articles_by_category
    search = search_params
    search[:filters] = { published: "published", category_id: params[:id] }
    @search = ArticleSearch.new(search)
    @articles = @search.result.objects
    render :articles
  end

  def search_articles
    params[:search][:filters] = { published: "published" }
    search = search_params
    @search = ArticleSearch.new(search)
    @articles = @search.result.objects
    render :articles
  end

  private

  def search_params
    params.permit(search: {})[:search] || {}
  end
end
