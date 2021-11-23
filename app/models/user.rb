class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :confirmable,
         :validatable,
         :lockable,
         :trackable
  mount_uploader :avatar, AvatarUploader

  enum role: { user: 0, admin: 1 }

  validates :first_name, length: { minimum: 2 }, presence: true
  validates :last_name, length: { minimum: 2 }, presence: true
  before_create :set_default_role

  scope :confirmed, -> { where.not(confirmed_at: nil) }
  scope :active, -> { where(locked_at: nil) }

  ransack_alias :user, :first_name_or_last_name

  paginates_per 10

  def full_name
    "#{first_name} #{last_name}"
  end

  def online?
    if current_sign_in_at.present?
      last_sign_out_at.present? ? current_sign_in_at > last_sign_out_at : true
    else
      false
    end
  end

  private

  def set_default_role
    self.role ||= :user
  end
end
