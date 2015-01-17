class AddSlugToTags < ActiveRecord::Migration
  def up
    add_column :tags, :slug, :text
  end

  def down
    remove_column :tags, :slug
  end
end
