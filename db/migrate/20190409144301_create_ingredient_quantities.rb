class CreateIngredientQuantities < ActiveRecord::Migration[5.1]
  def change
    create_table :ingredient_quantities do |t|
      t.belongs_to :micropost, index: true
      t.belongs_to :ingredient, index: true
      t.integer :quantity
      t.string :measure

      t.timestamps
    end
    
    add_index :ingredient_quantities, [:micropost_id, :ingredient_id], unique: true
  end
end
