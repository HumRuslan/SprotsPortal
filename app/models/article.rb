class Article < ApplicationRecord
  mount_uploader :picture, PictureUploader

  validates :picture, :headline, :caption, :alt_picture, :content, presence: true
  enum published: { published: 1, unpublished: 0 }

  before_save :set_default_params

  private

  def set_default_params
    self.comment = comment != "on"
    self.published ||= :unpublished
  end
end
