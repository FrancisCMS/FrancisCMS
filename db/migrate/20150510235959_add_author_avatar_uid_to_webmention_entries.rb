class AddAuthorAvatarUidToWebmentionEntries < ActiveRecord::Migration
  def up
    add_column :francis_cms_webmention_entries, :author_avatar_uid, :string
  end

  def down
    remove_column :francis_cms_webmention_entries, :author_avatar_uid
  end
end
