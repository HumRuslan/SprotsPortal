class Team < ApplicationRecord
  validates :name, :category_id, presence: true

  belongs_to :sub_category, inverse_of: :teams
  belongs_to :category, inverse_of: :teams

  default_scope { order("created_at DESC") }
end
