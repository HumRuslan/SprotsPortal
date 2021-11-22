class Account::Admin::SubCategoryController < Account::Admin::AdminApplicationController
  before_action :find_sub_category, only: %i[edit destroy update]

  def new
    @sub_category = Category.find(params[:category_id]).sub_categories.build
    authorize([:account, :admin, @sub_category])
    response_is
  end

  def create
    @sub_category = SubCategory.new(sub_category_params)
    flash[:alert] = "Error to create subcategory" unless @sub_category.save
    redirect_to account_admin_category_index_url
  end

  def edit
    response_is
  end

  def update
    flash[:alert] = "Error to update subcategory" unless @sub_category.update(sub_category_params)
    redirect_to account_admin_category_index_url
  end

  def destroy
    @sub_category.destroy
    redirect_to account_admin_category_index_url
  end

  private

  def sub_category_params
    params.require(:sub_category).permit(:name, :category_id)
  end

  def find_sub_category
    @sub_category = SubCategory.find(params['id'])
    authorize([:account, :admin, @sub_category])
  end

  def response_is
    respond_to do |format|
      format.js
    end
  end
end
