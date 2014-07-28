class CreateMyFavoriteRecipes < ActiveRecord::Migration
  def change
    create_table :my_favorite_recipes do |t|
      t.integer :food_item_id
      t.integer :hola_user_id
      t.timestamps
    end
  end
end
