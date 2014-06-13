class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.integer :dish_id
      t.string :ingredient_name
      t.integer :quantity
      t.string :special_remarks
      t.string :treatment
      t.string :cooking_equipment

      t.timestamps
    end
  end
end
