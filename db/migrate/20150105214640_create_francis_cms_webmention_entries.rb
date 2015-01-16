class CreateFrancisCmsWebmentionEntries < ActiveRecord::Migration
  def up
    create_table :francis_cms_webmention_entries do |t|
      t.belongs_to :webmention
      t.text       :entry_name
      t.text       :entry_content
      t.text       :entry_url
      t.text       :author_name
      t.text       :author_photo
      t.text       :author_url
      t.datetime   :published_at
    end
  end

  def down
    drop_table :francis_cms_webmention_entries
  end
end
