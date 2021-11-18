class Account::User::HomeController < Account::User::UserApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  def index
    search = search_params || {}
    search[:filters] = { published: "published" }
    @search = ArticleSearch.new(search)
    @articles = @search.result.objects
  end

  def show
    @article = Article.find(params['id'])
  end

  def search_params
    params[:search].permit(:query, filters: {}) if params.key? :search
  end
end
