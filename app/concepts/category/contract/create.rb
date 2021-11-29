require 'reform'
require 'reform/form/dry'

module Category::Contract
  class Create < Reform::Form
    feature Reform::Form::Dry

    property :name

    validation :default do
      params do
        required(:name).filled
      end
    end
  end
end
