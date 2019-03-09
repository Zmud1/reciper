class CreateIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :ingredients do |t|
      t.string :name

      t.timestamps
    end
    add_index :ingredients, :name
    
    create_table :ingredients_microposts, id: false do |t|
      t.belongs_to :ingredient, index: true
      t.belongs_to :micropost, index: true
    end
    
  end
end
