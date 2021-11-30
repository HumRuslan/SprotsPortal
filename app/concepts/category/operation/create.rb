class Category::Create < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(Category, :new)
    step Policy::Pundit(Account::Admin::CategoryPolicy, :create?)
    step Contract::Build(constant: Category::Contract::Create)
  end

  step Nested(Present)
  step :validate
  step Contract::Persist()

  def validate(options, model:, **)
    if options["contract.default"].validate(options["params"]["category"])
      true
    else
      options["contract.default"].errors.messages.each do |k, v|
        model.errors.add k, :invalid, message: v
      end
      false
    end
  end
end
