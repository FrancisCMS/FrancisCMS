class AddSlugToTags < ActiveRecord::Migration
  def up
    add_column :tags, :slug, :string, null: false
  end

  def down
    remove_column :tags, :slug
  end
end
