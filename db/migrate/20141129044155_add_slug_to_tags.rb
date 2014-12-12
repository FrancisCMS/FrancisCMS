class AddSlugToTags < ActiveRecord::Migration
  def up
    add_column :tags, :slug, :text, null: false
  end

  def down
    remove_column :tags, :slug
  end
end
