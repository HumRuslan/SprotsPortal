class Category::Update < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(Category, :find_by)
    fail :error_find
    step Policy::Pundit(Account::Admin::CategoryPolicy, :edit?)
    fail :error_auth
    step Contract::Build(constant: Category::Contract::Create)

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

  step Nested(Present)
  step Contract::Validate(key: :category)
  fail :error_message
  step Contract::Persist()

  def error_message(options, model:, **)
    options["contract.default"].errors.messages.each do |k, v|
      model.errors.add k, :invalid, message: v
    end
  end
end
