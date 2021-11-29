class Category::Delete < Trailblazer::Operation
  step Model(Category, :find_by)
  step Policy::Pundit(Account::Admin::CategoryPolicy, :destroy?)
  step :delete!

  def delete!(_options, model:, **)
    model.destroy
  end
end
