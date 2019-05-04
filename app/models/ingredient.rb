class Ingredient < ApplicationRecord
  has_many :ingredient_quantities
  has_many :microposts, through: :ingredient_quantities
  
  validates :name, presence: true, length: {maximum:50}, uniqueness: true
end

