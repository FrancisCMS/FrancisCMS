# This migration comes from francis_cms (originally 20150105190545)
class CreateFrancisCmsSyndications < ActiveRecord::Migration
  def up
    create_table :francis_cms_syndications do |t|
      t.text       :url, null: false
      t.text       :name, null: false
      t.references :syndicatable, polymorphic: true
      t.datetime   :created_at
    end
  end

  def down
    drop_table :francis_cms_syndications
  end
end
