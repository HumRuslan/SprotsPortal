class Article < ApplicationRecord
  mount_uploader :picture, PictureUploader

  validates :picture, :headline, :caption, :alt_picture, :content, presence: true
  enum published: { published: 1, unpublished: 0 }

  belongs_to :team, inverse_of: :articles

  paginates_per 5

  update_index('articles') { self }
end
