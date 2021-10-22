class User < ApplicationRecord
  VALID_PASSWORD = /(?=.*[0-9])(?=.*[!@#$%^&*])(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*]{6,}/.freeze

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP,
                                              message: "invalid email" }
  validates :password,
            confirmation: true,
            presence: true,
            format: { with: VALID_PASSWORD,
                      message: "password must contain small, large letters, special characters and numbers," \
                               " must be more than 5 characters" }
  validates :first_name, length: { minimum: 2 }, presence: true
  validates :last_name, length: { minimum: 2 }, presence: true
end
