class CreateCuisineGeographies < ActiveRecord::Migration
  def change
    create_table :cuisine_geographies do |t|
      t.string :name
      t.string :ancestry
      t.timestamps
    end
  end
end
