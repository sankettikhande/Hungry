class ChangeShortDescriptionDataTypeForMealInfos < ActiveRecord::Migration
  def change
		change_column :meal_infos, :short_description, :text
  end
end
