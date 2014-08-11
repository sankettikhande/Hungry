class RemoveSubmenuFromCms < ActiveRecord::Migration
  def up
    execute "Delete from content_type_groups where name = 'SubMenu';"
    execute "Delete from content_types where name = 'SubMenu';"
  end
end
