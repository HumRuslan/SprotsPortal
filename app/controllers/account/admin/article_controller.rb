class Account::Admin::ArticleController < Account::Admin::AdminApplicationController
  before_action :find_article, only: %i[published unpublished destroy]

  def index
    @search = ArticleSearch.new(search_params)
    @articles = @search.result.objects
    authorize(@articles, policy_class: Account::Admin::ArticlePolicy)
  end

  def new
    @article = Article.new
    authorize([:account, :admin, @article])
  end

  def create
    @article = Article.new(article_params)
    authorize([:account, :admin, @article])
    if @article.save
      redirect_to account_admin_article_index_url
    else
      render "new"
    end
  end

  def destroy
    @article.destroy
    redirect_to account_admin_article_index_url
  end

  def published
    @article.published!
    redirect_to account_admin_article_index_url
  end

  def unpublished
    @article.unpublished!
    redirect_to account_admin_article_index_url
  end

  private

  def article_params
    params.require(:article).permit(:picture, :headline, :caption, :alt_picture, :content, :comment)
  end

  def find_article
    @article = Article.find(params['id'])
    authorize([:account, :admin, @article])
  end

  def search_params
    params.permit(search: {})[:search] || {}
  end
end
