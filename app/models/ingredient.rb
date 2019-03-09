class Ingredient < ApplicationRecord
  has_and_belongs_to_many :microposts
  
  validates :name, presence: true, length: {maximum:50}, uniqueness: true
end

