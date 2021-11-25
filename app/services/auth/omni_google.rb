class Auth::OmniGoogle
  attr_accessor :data

  def initialize(access_token)
    @data = access_token.info
  end

  def user
    user = User.where(email: data['email']).first

    user ||= User.create(first_name: data['name'],
                         last_name: data['last_name'],
                         email: data['email'],
                         password: Devise.friendly_token[0, 20],
                         ext_service: true)

    user
  end
end
