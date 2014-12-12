class CreateLinks < ActiveRecord::Migration
  def up
    create_table :links do |t|
      t.text     :url, null: false
      t.text     :title, null: false
      t.text     :body
      t.datetime :published_at

      t.timestamps
    end
  end

  def down
    drop_table :links
  end
end
