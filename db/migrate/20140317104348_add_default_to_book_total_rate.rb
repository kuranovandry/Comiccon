class AddDefaultToBookTotalRate < ActiveRecord::Migration
  def change
    change_column :books, :total_rating_count, :integer, default: 0
    change_column :books, :total_rating_value, :integer, default: 0
  end
end
