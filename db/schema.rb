# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_19_104624) do

  create_table "collection_items", force: :cascade do |t|
    t.integer "collection_id"
    t.integer "item_id"
    t.boolean "deleted_flag"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "collection_tags", force: :cascade do |t|
    t.integer "collection_id"
    t.integer "tag_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "collections", force: :cascade do |t|
    t.string "name"
    t.text "describe"
    t.integer "user_id"
    t.integer "status"
    t.datetime "publish_at"
    t.datetime "private_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "item_download_counts", force: :cascade do |t|
    t.integer "item_id"
    t.integer "downloads", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "item_download_maps", force: :cascade do |t|
    t.integer "item_id"
    t.integer "user_id"
    t.datetime "download_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "item_exifs", force: :cascade do |t|
    t.integer "item_id"
    t.string "camera_maker"
    t.string "camera_model"
    t.integer "focus_length"
    t.float "aperture"
    t.integer "shutter_speed"
    t.integer "iso"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "item_like_counts", force: :cascade do |t|
    t.integer "item_id"
    t.integer "likes", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "item_like_maps", force: :cascade do |t|
    t.integer "item_id"
    t.integer "user_id"
    t.datetime "like_time"
    t.boolean "liked_flag", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "item_locations", force: :cascade do |t|
    t.integer "item_id"
    t.string "name"
    t.string "city"
    t.string "country"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "item_tag_maps", force: :cascade do |t|
    t.integer "item_id"
    t.integer "tag_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "item_uploads", force: :cascade do |t|
    t.integer "item_id"
    t.string "original_file_name"
    t.string "upload_status"
    t.string "upload_host"
    t.string "upload_ip"
    t.integer "user_id"
    t.integer "original_width"
    t.integer "original_height"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "item_view_counts", force: :cascade do |t|
    t.integer "item_id"
    t.integer "views", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "item_view_maps", force: :cascade do |t|
    t.integer "item_id"
    t.string "view_ip"
    t.datetime "view_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer "user_id"
    t.integer "content_type"
    t.text "description"
    t.integer "status"
    t.datetime "uploaded_at"
    t.integer "width"
    t.integer "height"
    t.datetime "remove_at"
    t.boolean "deleted_flag"
    t.string "submit_thumbnail_url"
    t.boolean "search_flag"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "photos", force: :cascade do |t|
    t.integer "item_id"
    t.string "color"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_photos_on_item_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_followings", force: :cascade do |t|
    t.integer "source_user_id"
    t.integer "target_user_id"
    t.boolean "follow_flag"
    t.datetime "following_time"
    t.datetime "unfollow_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "locked_at"
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "role"
    t.integer "user_type", limit: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "items", "users"
  add_foreign_key "photos", "items"
end
