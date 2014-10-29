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

ActiveRecord::Schema.define(version: 20141029221400) do

  create_table "links", force: true do |t|
    t.string   "url",          null: false
    t.string   "title",        null: false
    t.text     "body"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.string   "title",        null: false
    t.string   "slug",         null: false
    t.text     "body",         null: false
    t.string   "excerpt"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["slug"], name: "index_posts_on_slug", unique: true, using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type"], name: "index_taggings_on_tag_id_and_taggable_id_and_taggable_type", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string "name", null: false
    t.string "slug", null: false
  end

  add_index "tags", ["name", "slug"], name: "index_tags_on_name_and_slug", unique: true, using: :btree

  create_table "webmentions", force: true do |t|
    t.string   "source",              null: false
    t.string   "target",              null: false
    t.integer  "webmentionable_id"
    t.string   "webmentionable_type"
    t.string   "webmention_type"
    t.text     "html"
    t.text     "json"
    t.datetime "verified_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "webmentions", ["webmention_type"], name: "index_webmentions_on_webmention_type", using: :btree

end
