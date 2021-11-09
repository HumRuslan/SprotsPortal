class Account::User::HomeController < Account::User::UserApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  def index
    @articles = Article.all.published
  end

  def show
    id = params['id']
    begin
      @article = Article.find(id)
    rescue ActiveRecord::RecordNotFound
      flash["alert"] = 'Article not found'
      render file: "public/404.html", status: :not_found
    end
  end
end
