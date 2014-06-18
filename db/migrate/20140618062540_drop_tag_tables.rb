class DropTagTables < ActiveRecord::Migration
  def change
    execute("drop table tags")
    execute("drop table taggings")
  end
end
