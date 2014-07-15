class CreateCheffCuisineStyles < ActiveRecord::Migration
  def change
    create_table :cheff_cuisine_styles do |t|
      t.integer :cheff_id
      t.integer :cuisine_style_id
      t.timestamps
    end
  end
end
