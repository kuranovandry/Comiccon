class CreateCouriers < ActiveRecord::Migration
  def change
    create_table :couriers do |t|
      t.timestamps
      t.string :name, :limit => 100, :null => false
      t.string :surname, :limit => 100, :null => false
      t.string :delivery, :null => false
      t.text :notes
      t.datetime :deleted_at
    end
  end
end
