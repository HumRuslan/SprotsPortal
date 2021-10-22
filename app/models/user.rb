class User < ApplicationRecord
<<<<<<< HEAD
  VALID_PASSWORD = /(?=.*[0-9])(?=.*[!@#$%^&*])(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*]{6,}/.freeze

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP,
                                              message: "invalid email" }
=======
  validates :email, presence: true, length: { minimum: 6 }
>>>>>>> 66ebe0b11caba506d8500ac437fc674c171ad6dd
  validates :password,
            confirmation: true,
            presence: true,
            format: { with: VALID_PASSWORD,
                      message: "password must contain small, large letters, special characters and numbers," \
                               " must be more than 5 characters" }
<<<<<<< HEAD
  validates :first_name, length: { minimum: 2 }, unless: -> { first_name.blank? }
  validates :last_name, length: { minimum: 2 }, unless: -> { last_name.blank? }
=======
  validates :first_name, length: { minimum: 2 }, presence: true
  validates :last_name, length: { minimum: 2 }, presence: true
>>>>>>> 66ebe0b11caba506d8500ac437fc674c171ad6dd
end
