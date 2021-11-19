class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_fit: [800, 400]

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

  version :thumb do
    process resize_to_fit: [400, 200]
  end

  def extension_allowlist
    %w[jpg jpeg gif png]
  end

  def filename
    "#{Digest::MD5.hexdigest DateTime.now.strftime('%s')}.#{file.extension}"
  end
end
