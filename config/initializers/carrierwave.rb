CarrierWave.configure do |config|
  unless Rails.env.test?
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV.fetch('S3_KEY', ''),
      :aws_secret_access_key  => ENV.fetch('S3_SECRET', ''),
    }

    config.fog_directory  = ENV.fetch('S3_BUCKET', 'lolcommits-dot-com')
  end
end
