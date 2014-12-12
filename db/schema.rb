# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141212022726) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "links", force: true do |t|
    t.text     "url",          null: false
    t.text     "title",        null: false
    t.text     "body"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.text     "title",        null: false
    t.text     "slug",         null: false
    t.text     "body",         null: false
    t.text     "excerpt"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "syndications", force: true do |t|
    t.text     "url",               null: false
    t.text     "name",              null: false
    t.integer  "syndicatable_id"
    t.string   "syndicatable_type"
    t.datetime "created_at"
  end

  add_index "syndications", ["syndicatable_id", "syndicatable_type"], name: "index_syndications_on_syndicatable_id_and_syndicatable_type", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.text    "slug",                       null: false
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "webmention_entries", force: true do |t|
    t.integer  "webmention_id"
    t.text     "entry_name"
    t.text     "entry_content"
    t.text     "entry_url"
    t.text     "author_name"
    t.text     "author_photo"
    t.text     "author_url"
    t.datetime "published_at"
  end

  create_table "webmentions", force: true do |t|
    t.text     "source",              null: false
    t.text     "target",              null: false
    t.integer  "webmentionable_id"
    t.string   "webmentionable_type"
    t.string   "webmention_type"
    t.datetime "verified_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
