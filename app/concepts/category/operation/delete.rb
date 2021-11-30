class Category::Delete < Trailblazer::Operation
  step Model(Category, :find_by)
  step :error_find
  step Policy::Pundit(Account::Admin::CategoryPolicy, :destroy?)
  step :delete!

  def delete!(_options, model:, **)
    model.destroy
  end

  def error_find(_options, model:, **)
    return true unless model.nil?

    false
  end
end
