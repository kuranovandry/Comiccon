class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :shipping_address
      t.decimal :total_amount
      t.references :user, index: true

      t.timestamps
    end
  end
end
