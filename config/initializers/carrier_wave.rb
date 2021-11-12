CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage    =  :aws
  else
    config.storage    =  :file
  end

  config.aws_bucket =  Rails.application.credentials.aws[:s3_bucket]
  config.aws_acl    =  :private

  config.aws_credentials = {
    access_key_id:      Rails.application.credentials.aws[:access_key_id],
    secret_access_key:  Rails.application.credentials.aws[:secret_access_key] ,
    region: Rails.application.credentials.aws[:s3_region],
  }

  config.aws_attributes = -> {
    {
      expires: 1.week.from_now.httpdate,
      cache_control: 'max-age=604800'
    }
  }
end
