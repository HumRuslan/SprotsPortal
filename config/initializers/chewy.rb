if Rails.env.production?
  Chewy.settings = { host: ENV["FOUNDELASTICSEARCH_URL"].split("https://")[1] }
else
  Chewy.logger = Rails.logger
end
