# This migration comes from francis_cms (originally 20150107153747)
class AddSlugToTags < ActiveRecord::Migration
  def up
    add_column :tags, :slug, :text
  end

  def down
    remove_column :tags, :slug
  end
end
