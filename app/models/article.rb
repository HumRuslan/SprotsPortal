class Article < ApplicationRecord
  mount_uploader :picture, PictureUploader

  validates :picture, :headline, :caption, :alt_picture, :content, :team_id, presence: true
  enum published: { published: 1, unpublished: 0 }

  belongs_to :team, inverse_of: :articles, optional: true

  update_index('articles') { self }
end
