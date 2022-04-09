class BrandImageUploader < CarrierWave::Uploader::Base

  if Rails.env.production?
    storage :fog # 本番環境のみ
  else
    storage :file # 本番環境以外
  end

  #アップロードしたファイルの保存先を指定する。
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


  #アップロードを許可するファイル種類を指定する。
  def extension_allowlist
    %w(jpg jpeg gif png)
  end

  #画像がアップロードされてない時に、表示される画像
  def default_url
    'no_image.png'
  end
end
