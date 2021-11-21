class Team < ApplicationRecord
  validates :name, :sub_category_id, presence: true

  belongs_to :sub_category, inverse_of: :teams
  has_many :articles, dependent: :destroy, inverse_of: :team

  default_scope { order("created_at DESC") }

  update_index('articles') { articles }
end
