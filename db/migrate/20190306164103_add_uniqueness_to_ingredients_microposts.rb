class AddUniquenessToIngredientsMicroposts < ActiveRecord::Migration[5.1]
  def change
    add_index :ingredients_microposts, [:ingredient_id, :micropost_id], :unique => true
  end
end
