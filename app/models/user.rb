class User < ApplicationRecord
  validates :email, presence: true, length: { minimum: 6 }
  validates :password,
            confirmation: true,
            presence: true,
            format: { with: VALID_PASSWORD,
                      message: "password must contain small, large letters, special characters and numbers," \
                               " must be more than 5 characters" }
  validates :first_name, length: { minimum: 2 }, presence: true
  validates :last_name, length: { minimum: 2 }, presence: true
end
