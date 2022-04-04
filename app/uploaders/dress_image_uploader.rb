class DressImageUploader < CarrierWave::Uploader::Base


    storage :fog


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
