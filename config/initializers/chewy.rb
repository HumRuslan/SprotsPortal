if Rails.env.production?
  Chewy.settings = { host: ENV["FOUNDELASTICSEARCH_URL"] }
else
  Chewy.logger = Rails.logger
end
