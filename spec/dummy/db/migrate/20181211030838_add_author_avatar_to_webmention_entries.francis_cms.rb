# This migration comes from francis_cms (originally 20151030160826)
class AddAuthorAvatarToWebmentionEntries < ActiveRecord::Migration
  def up
    add_column :francis_cms_webmention_entries, :author_avatar, :text
  end

  def down
    remove_column :francis_cms_webmention_entries, :author_avatar
  end
end
