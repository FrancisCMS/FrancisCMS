# This migration comes from francis_cms (originally 20151129060334)
class AddLatLngToPhotos < ActiveRecord::Migration
  def up
    add_column :francis_cms_photos, :latitude, :float
    add_column :francis_cms_photos, :longitude, :float
  end

  def down
    remove_column :francis_cms_photos, :latitude
    remove_column :francis_cms_photos, :longitude
  end
end
