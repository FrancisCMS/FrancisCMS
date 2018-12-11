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

ActiveRecord::Schema.define(version: 20181211030842) do

  create_table "francis_cms_links", force: :cascade do |t|
    t.text     "url",          null: false
    t.text     "title",        null: false
    t.text     "body"
    t.datetime "published_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "francis_cms_photos", force: :cascade do |t|
    t.text     "photo",          null: false
    t.text     "body"
    t.datetime "published_at"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.float    "latitude"
    t.float    "longitude"
    t.text     "street_address"
    t.text     "city"
    t.text     "state"
    t.text     "state_code"
    t.text     "postal_code"
    t.text     "country"
    t.text     "country_code"
    t.datetime "taken_at"
  end

  create_table "francis_cms_posts", force: :cascade do |t|
    t.text     "title",        null: false
    t.text     "slug",         null: false
    t.text     "body",         null: false
    t.text     "excerpt"
    t.datetime "published_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "francis_cms_syndications", force: :cascade do |t|
    t.text     "url",               null: false
    t.text     "name",              null: false
    t.integer  "syndicatable_id"
    t.string   "syndicatable_type"
    t.datetime "created_at"
  end

  create_table "francis_cms_webmention_entries", force: :cascade do |t|
    t.integer  "webmention_id"
    t.text     "entry_name"
    t.text     "entry_content"
    t.text     "entry_url"
    t.text     "author_name"
    t.text     "author_photo_url"
    t.text     "author_url"
    t.datetime "published_at"
    t.text     "author_avatar"
  end

  create_table "francis_cms_webmentions", force: :cascade do |t|
    t.text     "source",              null: false
    t.text     "target",              null: false
    t.integer  "webmentionable_id"
    t.string   "webmentionable_type"
    t.string   "webmention_type"
    t.datetime "verified_at"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.text     "fragmention"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.text    "slug"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

end
