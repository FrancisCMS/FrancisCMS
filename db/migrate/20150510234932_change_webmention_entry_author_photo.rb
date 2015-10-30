class ChangeWebmentionEntryAuthorName < ActiveRecord::Migration
  def up
    rename_column :francis_cms_webmention_entries, :author_photo, :author_photo_url
  end

  def down
    rename_column :francis_cms_webmention_entries, :author_photo_url, :author_photo
  end
end
