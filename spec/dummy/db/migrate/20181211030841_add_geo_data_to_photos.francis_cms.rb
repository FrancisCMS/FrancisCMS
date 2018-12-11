# This migration comes from francis_cms (originally 20151129063316)
class AddGeoDataToPhotos < ActiveRecord::Migration
  def up
    add_column :francis_cms_photos, :street_address, :text
    add_column :francis_cms_photos, :city, :text
    add_column :francis_cms_photos, :state, :text
    add_column :francis_cms_photos, :state_code, :text
    add_column :francis_cms_photos, :postal_code, :text
    add_column :francis_cms_photos, :country, :text
    add_column :francis_cms_photos, :country_code, :text
  end

  def down
    remove_column :francis_cms_photos, :street_address
    remove_column :francis_cms_photos, :city
    remove_column :francis_cms_photos, :state
    remove_column :francis_cms_photos, :state_code
    remove_column :francis_cms_photos, :postal_code
    remove_column :francis_cms_photos, :country
    remove_column :francis_cms_photos, :country_code
  end
end
