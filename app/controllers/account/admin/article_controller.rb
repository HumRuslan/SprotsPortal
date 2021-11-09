class Account::Admin::ArticleController < Account::Admin::AdminApplicationController
  def index
    @articles = Article.all
    authorize([:account, :admin, @articles])
  end

  def new
    @article = Article.new
    authorize([:account, :admin, @article])
  end

  def create
    @article = Article.new(article_params)
    authorize([:account, :admin, @article])
    if @article.save
      redirect_to account_admin_article_index_path
    else
      render "new"
    end
  end

  private

  def article_params
    params.require(:article).permit(:picture, :headline, :caption, :alt_picture, :content, :comment)
  end
end
