class Category::Delete < Trailblazer::Operation
  step Model(Category, :find_by)
  fail :error_find
  step Policy::Pundit(Account::Admin::CategoryPolicy, :destroy?)
  fail :error_auth
  step :delete!

  def delete!(_options, model:, **)
    model.destroy
  end

  def error_find(options, **)
    options["result.errors"] = {
      message: "Not found"
    }
  end

  def error_auth(options, **)
    options["result.errors"] = {
      message: "Unauthorized"
    }
  end
end
