class CreateFrancisCmsLinks < ActiveRecord::Migration
  def up
    create_table :francis_cms_links do |t|
      t.text     :url, null: false
      t.text     :title, null: false
      t.text     :body
      t.datetime :published_at

      t.timestamps null: false
    end
  end

  def down
    drop_table :francis_cms_links
  end
end
