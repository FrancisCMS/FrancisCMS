class CreateWebmentions < ActiveRecord::Migration
  def up
    create_table :webmentions do |t|
      t.text       :source, null: false
      t.text       :target, null: false
      t.references :webmentionable, polymorphic: true
      t.string     :webmention_type, length: 20
      t.datetime   :verified_at

      t.timestamps
    end

    # add_index :webmentions, :webmention_type
  end

  def down
    drop_table :webmentions
  end
end
