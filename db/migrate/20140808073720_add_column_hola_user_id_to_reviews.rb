class AddColumnHolaUserIdToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :hola_user_id, :integer
  end
end
