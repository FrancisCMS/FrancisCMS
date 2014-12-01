class CreateWebmentions < ActiveRecord::Migration
  def up
    create_table :webmentions do |t|
      t.string     :source, null: false
      t.string     :target, null: false
      t.references :webmentionable, polymorphic: true
      t.string     :webmention_type
      t.text       :html
      t.text       :json
      t.datetime   :verified_at

      t.timestamps
    end

    add_index :webmentions, :webmention_type
  end

  def down
    drop_table :webmentions
  end
end
