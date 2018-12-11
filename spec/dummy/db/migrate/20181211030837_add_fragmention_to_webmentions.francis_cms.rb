# This migration comes from francis_cms (originally 20150810233720)
class AddFragmentionToWebmentions < ActiveRecord::Migration
  def up
    add_column :francis_cms_webmentions, :fragmention, :text
  end

  def down
    remove_column :francis_cms_webmentions, :fragmention
  end
end
