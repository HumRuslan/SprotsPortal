if Rails.env.production?
  Chewy.settings = { host: ENV["FOUNDELASTICSEARCH_URL"].split("https://")[1],
                     schema: "https",
                     port: "9243"}
else
  Chewy.logger = Rails.logger
end
