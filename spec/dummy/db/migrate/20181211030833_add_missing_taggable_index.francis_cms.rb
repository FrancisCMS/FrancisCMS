# This migration comes from francis_cms (originally 20150107153503)
# This migration comes from acts_as_taggable_on_engine (originally 4)
class AddMissingTaggableIndex < ActiveRecord::Migration
  def self.up
    add_index :taggings, [:taggable_id, :taggable_type, :context]
  end

  def self.down
    remove_index :taggings, [:taggable_id, :taggable_type, :context]
  end
end
