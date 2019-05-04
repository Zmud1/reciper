class IngredientQuantity < ApplicationRecord
  belongs_to :micropost
  belongs_to :ingredient
end
