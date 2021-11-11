Sidekiq.configure_server do |config|
  if Rails.env.development?
    config.redis = { url: 'redis://localhost:6379/0' }
  end
  if Rails.env.production?
    config.redis = { url: ENV['REDIS_URL'], size: 4, network_timeout: 5 }
  end
  schedule_file = "config/schedule.yml"
  if File.exist?(schedule_file) && Sidekiq.server?
    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  end
end

Sidekiq.configure_client do |config|
  if Rails.env.development?
    config.redis = { url: 'redis://localhost:6379/0' }
  end
  if Rails.env.production?
    config.redis = { url: ENV['REDIS_URL'], size: 4, network_timeout: 5 }
  end
end

