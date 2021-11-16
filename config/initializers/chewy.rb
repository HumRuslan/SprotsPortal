if Rails.env.production?
  Chewy.settings = { host: Rails.application.credentials.bonsai[:url] }
else
  Chewy.logger = Rails.logger
end
