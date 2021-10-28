class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :confirmable

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false, message: "has already exist" },
            format: { with: URI::MailTo::EMAIL_REGEXP, message: "invalid email" }
  validates :password,
            confirmation: true,
            presence: true,
            length: { minimum: 6 }
  validates :first_name, length: { minimum: 2 }, presence: true
  validates :last_name, length: { minimum: 2 }, presence: true
end
