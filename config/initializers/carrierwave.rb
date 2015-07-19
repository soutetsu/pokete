if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_credentials = {
        provider:              'AWS',
        aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
        aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
        region:                'ap-northeast-1',
    }
    config.fog_directory = 'rails-training'
    config.fog_public = true
  end
else
  CarrierWave.configure do |config|
    config.storage = :file
  end
end
