class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :confirmable,
         :validatable,
         :lockable
  enum role: { user: 0, admin: 1 }

  validates :first_name, length: { minimum: 2 }, presence: true
  validates :last_name, length: { minimum: 2 }, presence: true
  before_create :set_default_role

  scope :confirmed, -> { where.not(confirmed_at: nil) }
  scope :active, -> { where(locked_at: nil) }

  ransack_alias :user, :first_name_or_last_name

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def set_default_role
    self.role ||= :user
  end
end
