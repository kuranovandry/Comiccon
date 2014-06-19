class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :description
      t.string :author_name
      t.string :publisher_name
      t.date :published_date
      t.integer :unit_price
      t.string :photo
      t.integer :total_rating_value
      t.integer :total_rating_count

      t.timestamps
    end
  end
end
