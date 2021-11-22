class Team < ApplicationRecord
  validates :name, presence: true

  belongs_to :sub_category, inverse_of: :teams
  has_many :articles, dependent: :destroy, inverse_of: :team

  default_scope { order("created_at DESC") }
end
