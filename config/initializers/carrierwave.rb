require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
    config.storage :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory  = 'nemo-brand'
    config.fog_credentials = {
      provider: 'AWS',
      # aws_access_key_id: Settings.AWS_ACCESS_KEY_ID, # 環境変数
      # aws_secret_access_key: Settings.AWS_SECRET_ACCESS_KEY, # 環境変数
      aws_access_key_id: 'AKIA2XCTYBW4YRPAH6EC',
      aws_secret_access_key: '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',
      region: 'ap-northeast-1',   # アジアパシフィック(東京)を選択した場合
    }
end