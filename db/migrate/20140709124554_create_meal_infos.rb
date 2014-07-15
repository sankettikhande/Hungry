class CreateMealInfos < ActiveRecord::Migration
  def change
    create_table :meal_infos do |t|
      t.integer :food_item_id
      t.string :name
      t.text :description
      t.integer :preorder_time
      t.integer :portion_size
      t.integer :minimum_order_qty
      t.integer :hola_buy_price
      t.integer :hola_sell_price

      t.timestamps
    end
  end
end
