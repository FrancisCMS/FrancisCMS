class CreatePosts < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.text   :title, null: false
      t.text   :slug, null: false
      t.text     :body, null: false
      t.text   :excerpt
      t.datetime :published_at

      t.timestamps
    end
  end

  def down
    drop_table :posts
  end
end
