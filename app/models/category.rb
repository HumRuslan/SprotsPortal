class Category < ApplicationRecord
  validates :name, presence: true

  has_many :sub_categories, dependent: :destroy, inverse_of: :category
  has_many :teams, dependent: :destroy, inverse_of: :category

  default_scope { order("created_at DESC") }
end
