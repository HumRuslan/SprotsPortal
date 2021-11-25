class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :confirmable,
         :validatable,
         :lockable,
         :trackable,
         :omniauthable, omniauth_providers: [:google_oauth2]

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
    last_sign_out_at.present? ? last_sign_out_at > Time.current : false
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    unless user
      user = User.create(first_name: data['name'],
                         last_name: data['family_name'],
                         email: data['email'],
                         password: Devise.friendly_token[0, 20],
                         ext_service: true)
      user.confirm
    end

    user
  end

  private

  def set_default_role
    self.role ||= :user
  end
end
