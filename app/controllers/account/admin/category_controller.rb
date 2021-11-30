class Account::Admin::CategoryController < Account::Admin::AdminApplicationController
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
    result = run Category::Create
    if result.success?
      flash[:notice] = "Category was created"
      return redirect_to account_admin_category_index_url
    end
    response_js
    render :new
  end

  def edit
    result = run Category::Update::Present
    response_js
    return render :not_found unless result.success?
  end

  def update
    result = run Category::Update
    if result.success?
      flash[:notice] = "Category was updated"
      return redirect_to account_admin_category_index_url
    end
    response_js
    render :edit
  end

  def destroy
    result = run Category::Delete
    raise ActiveRecord::RecordNotFound unless result.success?

    redirect_to account_admin_category_index_url
  end

  private

  def response_js
    respond_to do |format|
      format.js
    end
  end

  def _run_options(options)
    options.merge("current_user" => current_user)
  end
end
