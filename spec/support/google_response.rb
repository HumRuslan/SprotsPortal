module GoogleResponse
  def stub_omniauth
    before do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
                                                                           "provider" => "google_oauth2",
                                                                           "uid" => "100000000000000000000",
                                                                           "info" => {
                                                                             "name" => "John Smith",
                                                                             "email" => "john@example.com",
                                                                             "first_name" => "John",
                                                                             "last_name" => "Smith",
                                                                             "image" => "https://lh4.googleusercontent.com/photo.jpg",
                                                                             "urls" => {
                                                                               "google" => "https://plus.google.com/+JohnSmith"
                                                                             }
                                                                           }
                                                                         })
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    end
  end
end
