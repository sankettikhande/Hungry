class CreateCookingTodays < ActiveRecord::Migration
  def change
    Cms::ContentType.create!(:name => "CookingToday", :group_name => "CookingToday")
    create_content_table :cooking_todays, :prefix=>false do |t|
      t.integer :cheff_id
      t.integer :dish_id
      t.integer :quantity
      t.integer :ordered
      t.date :date

      t.timestamps
    end
  end
end
