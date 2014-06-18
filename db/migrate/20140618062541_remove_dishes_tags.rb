class RemoveDishesTags < ActiveRecord::Migration
  remove_column :dishes, :tags
end