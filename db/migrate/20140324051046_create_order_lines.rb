class CreateOrderLines < ActiveRecord::Migration
  def change
    create_table :order_lines do |t|
      t.decimal :unit_price
      t.integer :quantity
      t.references :order, index: true
      t.references :book, index: true

      t.timestamps
    end
  end
end
