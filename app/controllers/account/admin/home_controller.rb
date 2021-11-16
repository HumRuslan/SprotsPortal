class Account::Admin::HomeController < Account::Admin::AdminApplicationController
  def index
    @search = ArticleSearch.new(search_params)
  end

  def search_params
    params[:search].permit(:query) if params[:search].present?
  end
end
