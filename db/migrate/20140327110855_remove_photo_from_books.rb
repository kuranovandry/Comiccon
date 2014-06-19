class RemovePhotoFromBooks < ActiveRecord::Migration
  def change
    remove_column :books, :photo, :string
  end
end
