class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.integer :food_item_id
      t.text :garnishing_tips
      t.text :serving_tips
      t.text :storage_instructions
      t.string :shelf_life
      t.string :equipment_required

      t.timestamps
    end
  end
end
