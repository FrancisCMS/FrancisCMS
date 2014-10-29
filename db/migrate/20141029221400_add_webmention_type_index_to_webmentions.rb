class AddWebmentionTypeIndexToWebmentions < ActiveRecord::Migration
  def up
    add_index :webmentions, :webmention_type
  end

  def down
    remove_index :webmentions, :webmention_type
  end
end
