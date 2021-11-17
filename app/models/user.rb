class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :confirmable,
         :validatable,
         :lockable
  mount_uploader :avatar, AvatarUploader

  attr_accessor :old_password

  enum role: { user: 0, admin: 1 }

  validates :first_name, length: { minimum: 2 }, presence: true
  validates :last_name, length: { minimum: 2 }, presence: true
  validate :old_password_confirmation, if: -> { changes[:encrypted_password] }
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

  def old_password_confirmation
    errors.add :old_password, message: "Old password isn't correct" unless valid_password?(old_password)
  end
end
