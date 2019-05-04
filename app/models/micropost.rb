class Micropost < ApplicationRecord
  belongs_to :user
  has_many :ingredient_quantities
  has_many :ingredients, through: :ingredient_quantities
  accepts_nested_attributes_for :ingredient_quantities
 
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum:140}
  validate :picture_size
  
 #This is for the unoptimal method Ingredient.all.collect{|x| attr_accessor x.name}
  
  def picture_size
    if picture.size > 2.megabytes
      errors.add(:picture, " is too large! It must be smaller than 2 megabytes")
    end
  end
  
end
