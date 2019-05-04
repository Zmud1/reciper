class ChangeQuantityToFloat < ActiveRecord::Migration[5.1]
   def change
    change_column :ingredient_quantities, :quantity, :float
  end
end
