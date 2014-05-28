class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
    	t.string :name_surname, :limit => 100, :null => false
      t.string :country
      t.string :street
      t.string :delivery
      t.string :payment_method
      t.integer :total_price
      t.text :notes
      t.timestamps
    end
  end
end
