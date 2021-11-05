class Article < ApplicationRecord
  mount_uploader :picture, PictureUploader

  validates :picture, :headline, :caption, :alt_picture, :content, presence: true
  enum published: { published: 1, unpublished: 0 }
end
