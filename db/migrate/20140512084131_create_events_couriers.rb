class CreateEventsCouriers < ActiveRecord::Migration
  def change
    create_table :events_couriers do |t|
    	t.integer  :event_id
    	t.integer  :courier_id
      t.timestamps
    end
  end
end
