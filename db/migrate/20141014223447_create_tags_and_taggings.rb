class CreateTagsAndTaggings < ActiveRecord::Migration
  def up
    create_table :tags do |t|
      t.string :name, null: false
      t.string :slug, null: false
    end

    add_index :tags, [:name, :slug], unique: true

    create_table :taggings do |t|
      t.references :tag
      t.references :taggable, polymorphic: true
      t.datetime   :created_at
    end

    add_index :taggings, [:tag_id, :taggable_id, :taggable_type], unique: true
  end

  def down
    drop_table :taggings
    drop_table :tags
  end
end
