class AddColumnShortDescriptionToMealInfos < ActiveRecord::Migration
  def change
  	add_column :meal_infos, :short_description, :string
  end
end
