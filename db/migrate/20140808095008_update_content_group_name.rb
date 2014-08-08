class UpdateContentGroupName < ActiveRecord::Migration
  def up
    execute("update content_type_groups set name = 'Chef' where name = 'Cheff' ")
  end

  def down
  end
end
