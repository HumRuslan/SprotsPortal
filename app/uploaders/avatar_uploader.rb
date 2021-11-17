class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process resize_to_fit: [400, 400]

  def store_dir
    "uploads/avatar/#{model.id}"
  end
end
