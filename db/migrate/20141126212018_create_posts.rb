class CreatePosts < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.string   :title, null: false
      t.string   :slug, null: false
      t.text     :body, null: false
      t.string   :excerpt
      t.datetime :published_at

      t.timestamps
    end
  end

  def down
    drop_table :posts
  end
end
