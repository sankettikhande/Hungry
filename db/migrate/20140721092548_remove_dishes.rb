class RemoveDishes < ActiveRecord::Migration
  def up
    execute("delete from content_type_groups where name = 'Dish'")
    execute("delete from content_types where name = 'Dish'")
    execute("drop table dishes")
  end

  def down
  end
end
