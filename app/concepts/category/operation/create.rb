class Category::Create < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(Category, :new)
    step Policy::Pundit(Account::Admin::CategoryPolicy, :create?)
    step Contract::Build(constant: Category::Contract::Create)
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
