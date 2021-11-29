class Account::Admin::CategoryController < Account::Admin::AdminApplicationController
  before_action :find_category, only: %i[edit destroy update]

  def index
    @categories = Category.includes(:sub_categories).order(created_at: :desc)
    authorize([:account, :admin, @categories])
  end

  def new
    run Category::Create::Present
    authorize([:account, :admin, @model])
    response_js
  end

  def create
    run Category::Create do |_result|
      flash[:notice] = "Category was created"
      return redirect_to account_admin_category_index_url
    end
    flash[:alert] = "Error to create category"
    redirect_to account_admin_category_index_url
  end

  def edit
    run Category::Update::Present
    response_js
  end

  def update
    run Category::Update do |_result|
      flash[:notice] = "Category was updated"
      return redirect_to account_admin_category_index_url
    end
    flash[:alert] = "Error to update category"
    redirect_to account_admin_category_index_url
  end

  def destroy
    run Category::Delete
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

  def response_js
    respond_to do |format|
      format.js
    end
  end

  def _run_options(options)
    options.merge("current_user" => current_user)
  end
end
