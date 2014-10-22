class CreateWebmentions < ActiveRecord::Migration
  def up
    create_table :webmentions do |t|
      t.string   :source, null: false
      t.string   :target, null: false
      t.string   :webmention_type
      t.text     :html
      t.text     :json
      t.datetime :verified_at
      t.timestamps
    end
  end

  def down
    drop_table :webmentions
  end
end
