# This migration comes from francis_cms (originally 20151203034847)
class AddTakenAtToPhotos < ActiveRecord::Migration
  def up
    add_column :francis_cms_photos, :taken_at, :datetime
  end

  def down
    remove_column :francis_cms_photos, :taken_at
  end
end
