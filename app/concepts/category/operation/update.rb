class Category::Update < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(Category, :find_by)
    step :error_find
    step Policy::Pundit(Account::Admin::CategoryPolicy, :edit?)
    step Contract::Build(constant: Category::Contract::Create)

    def error_find(_options, model:, **)
      return true unless model.nil?

      false
    end
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
