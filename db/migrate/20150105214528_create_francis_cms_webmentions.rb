class CreateFrancisCmsWebmentions < ActiveRecord::Migration
  def up
    create_table :francis_cms_webmentions do |t|
      t.text       :source, null: false
      t.text       :target, null: false
      t.references :webmentionable, polymorphic: true
      t.string     :webmention_type, length: 20
      t.datetime   :verified_at

      t.timestamps null: false
    end
  end

  def down
    drop_table :francis_cms_webmentions
  end
end
