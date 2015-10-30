class AddAuthorAvatarToWebmentionEntries < ActiveRecord::Migration
  def up
    add_column :francis_cms_webmention_entries, :author_avatar, :text
  end

  def down
    remove_column :francis_cms_webmention_entries, :author_avatar
  end
end
