class Category < ApplicationRecord
  validates :name, presence: true

  has_many :sub_categories, dependent: :destroy, inverse_of: :category

  default_scope { order("created_at DESC") }

  update_index('articles') { articles }
end
