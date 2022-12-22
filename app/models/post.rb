class Post < ApplicationRecord
  mount_uploader :thumbnail, ThumbnailUploader
  belongs_to :user

  validates :title, :description, presence: true
end
