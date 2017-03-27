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

ActiveRecord::Schema.define(version: 20170327220154) do

  create_table "albums", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "description", limit: 65535
    t.boolean  "private"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "identifier"
    t.string   "secret"
    t.index ["identifier"], name: "index_albums_on_identifier", unique: true, using: :btree
  end

  create_table "albums_images", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "image_id", null: false
    t.integer "album_id", null: false
    t.index ["album_id", "image_id"], name: "index_albums_images_on_album_id_and_image_id", using: :btree
    t.index ["image_id", "album_id"], name: "index_albums_images_on_image_id_and_album_id", using: :btree
  end

  create_table "images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "description", limit: 65535
    t.boolean  "private"
    t.boolean  "thumb"
    t.boolean  "small"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "image"
    t.string   "secret"
    t.string   "identifier"
    t.index ["identifier"], name: "index_images_on_identifier", unique: true, using: :btree
  end

end
