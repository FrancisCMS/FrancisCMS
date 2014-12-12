class CreateSyndications < ActiveRecord::Migration
  def up
    create_table :syndications do |t|
      t.text       :url, null: false
      t.text       :name, null: false
      t.references :syndicatable, polymorphic: true, index: true
      t.datetime   :created_at
    end

    # add_index :syndications, :url, unique: true
  end

  def down
    drop_table :syndications
  end
end
