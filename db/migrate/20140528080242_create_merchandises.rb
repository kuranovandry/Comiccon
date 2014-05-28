class CreateMerchandises < ActiveRecord::Migration
  def change
    create_table :merchandises do |t|
    	t.string :name
    	t.integer :price
    	t.integer :order_id
    	t.string :notes
      t.timestamps
    end
  end
end
