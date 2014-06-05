class RemoveOrderedMenuBlock < ActiveRecord::Migration
  def up
    execute("delete from content_type_groups where name = 'OrderedMenu'")
    execute("delete from content_types where name = 'OrderedMenu'")
  end

  def down
  end
end
