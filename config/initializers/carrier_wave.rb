CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider => 'AWS',
    :aws_access_key_id => Rails.application.credentials[:aws_access_key_id],
    :aws_secret_access_key => Rails.application.credentials[:aws_secret_access_key],
  }
  config.fog_directory = Rails.application.credentials[:aws_s2_bucket]
  # Choose what kind of storage to use for this uploader:
  if Rails.env.production?
    config.storage :fog
  else
    config.storage :file
  end
  config.cache_dir = "#{Rails.root}/tmp/uploads"
end
