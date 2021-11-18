class Account::Admin::CategoryController < Account::Admin::AdminApplicationController
  before_action :find_category, only: %i[edit destroy update]

  def index
    @categories = Category.includes(:sub_categories).order(created_at: :desc)
    authorize([:account, :admin, @categories])
  end

  def new
    @category = Category.new
    authorize([:account, :admin, @category])
    response_is
  end

  def create
    @category = Category.new(category_params)
    flash[:alert] = "Error to create category" unless @category.save
    redirect_to account_admin_category_index_url
  end

  def edit
    response_is
  end

  def update
    flash[:alert] = "Error to update category" unless @category.update(category_params)
    redirect_to account_admin_category_index_url
  end

  def destroy
    @category.destroy
    redirect_to account_admin_category_index_url
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def find_category
    @category = Category.find(params['id'])
    authorize([:account, :admin, @category])
  end

  def response_is
    respond_to do |format|
      format.js
    end
  end
end
