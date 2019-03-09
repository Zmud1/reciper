class Micropost < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :ingredients
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum:140}
  validate :picture_size
  
  def picture_size
    if picture.size > 2.megabytes
      errors.add(:picture, " is too large! It must be smaller than 2 megabytes")
    end
  end
      
  
end
