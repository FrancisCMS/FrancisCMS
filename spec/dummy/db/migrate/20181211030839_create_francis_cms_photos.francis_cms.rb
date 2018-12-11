# This migration comes from francis_cms (originally 20151108042924)
class CreateFrancisCmsPhotos < ActiveRecord::Migration
  def up
    create_table :francis_cms_photos do |t|
      t.text     :photo, null: false
      t.text     :body
      t.datetime :published_at

      t.timestamps null: false
    end
  end

  def down
    drop_table :francis_cms_photos
  end
end
