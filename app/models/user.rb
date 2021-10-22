class User < ApplicationRecord
  validates :email, presence: true, length: { minimum: 6 }
  validates :password,
            confirmation: true,
            presence: true,
            length: { minimum: 6 }
  validates :first_name, length: { minimum: 2 }, presence: true
  validates :last_name, length: { minimum: 2 }, presence: true
end
