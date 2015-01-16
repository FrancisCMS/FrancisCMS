class CreateFrancisCmsPosts < ActiveRecord::Migration
  def up
    create_table :francis_cms_posts do |t|
      t.text     :title, null: false
      t.text     :slug, null: false
      t.text     :body, null: false
      t.text     :excerpt
      t.datetime :published_at

      t.timestamps null: false
    end
  end

  def down
    drop_table :francis_cms_posts
  end
end
