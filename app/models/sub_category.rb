class SubCategory < ApplicationRecord
  validates :name, :category_id, presence: true

  belongs_to :category, -> { includes(:teams) }, inverse_of: :sub_categories
  has_many :teams, dependent: :destroy, inverse_of: :sub_category

  default_scope { order("created_at DESC") }
end
