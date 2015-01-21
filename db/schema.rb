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

ActiveRecord::Schema.define(version: 20150113192331) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "recommendations", force: :cascade do |t|
    t.string   "title"
    t.string   "year"
    t.string   "rated"
    t.string   "released"
    t.string   "runtime"
    t.string   "genre"
    t.string   "director"
    t.string   "writer"
    t.string   "actors"
    t.string   "plot"
    t.string   "language"
    t.string   "country"
    t.string   "awards"
    t.string   "poster"
    t.string   "metascore"
    t.string   "imdb_rating"
    t.string   "imdb_ID"
    t.string   "media_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "user_recommendations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "recommendation_id"
    t.integer  "count",             default: 0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "screen_name"
    t.string   "uid"
    t.string   "provider"
    t.string   "profile_image"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
