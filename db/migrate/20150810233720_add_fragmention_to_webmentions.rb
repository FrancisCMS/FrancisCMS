class AddFragmentionToWebmentions < ActiveRecord::Migration
  def up
    add_column :francis_cms_webmentions, :fragmention, :text
  end

  def down
    remove_column :francis_cms_webmentions, :fragmention
  end
end
