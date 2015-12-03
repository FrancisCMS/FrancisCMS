class AddTakenAtToPhotos < ActiveRecord::Migration
  def up
    add_column :francis_cms_photos, :taken_at, :datetime
  end

  def down
    remove_column :francis_cms_photos, :taken_at
  end
end
