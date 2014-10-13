class CreateTagsAndTaggings < ActiveRecord::Migration
  def up
    create_table :tags do |t|
      t.string  :name, null: false
      t.string  :slug, null: false
      t.integer :taggings_count, default: 0
    end

    add_index :tags, [:name, :slug], unique: true

    create_table :taggings do |t|
      t.references :tag
      t.references :taggable, polymorphic: true
      t.string     :context, limit: 128
      t.datetime   :created_at
    end

    add_index :taggings, [:tag_id, :context], unique: true
    add_index :taggings, [:taggable_type, :taggable_id], unique: true
  end

  def down
    drop_table :taggings
    drop_table :tags
  end
end
