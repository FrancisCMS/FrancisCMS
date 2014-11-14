class CreateSyndications < ActiveRecord::Migration
  def up
    create_table :syndications do |t|
      t.string     :url, null: false
      t.string     :name, null: false
      t.references :syndicatable, polymorphic: true
    end

    add_index :syndications, :url, unique: true
    add_index :syndications, [:syndicatable_id, :syndicatable_type]
  end

  def down
    drop_table :syndications
  end
end
