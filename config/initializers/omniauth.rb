Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.credentials.google[:client_id], Rails.application.credentials.google[:client_secret]
  if Rails.env.production?
    provider :google_oauth2, Rails.application.credentials.google[:client_id], Rails.application.credentials.google[:client_secret], {
      redirect_uri: 'https://whispering-meadow-70531.herokuapp.com/users/auth/google_oauth2/callback'
    }
  end
end

OmniAuth.config.allowed_request_methods = %i[get]
