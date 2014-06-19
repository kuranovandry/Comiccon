class ChangePriceFormatInBooks < ActiveRecord::Migration
  def change
    change_column :books, :unit_price, :decimal
  end
end
