class CreateMyFavoriteChefs < ActiveRecord::Migration
  def change
    create_table :my_favorite_chefs do |t|
      t.integer :cheff_id
      t.integer :hola_user_id
      t.timestamps
    end
  end
end
