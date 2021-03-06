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

ActiveRecord::Schema.define(version: 20160820215402) do

  create_table "countries", force: :cascade do |t|
    t.string  "country_code",      limit: 255
    t.integer "panel_provider_id", limit: 4
  end

  create_table "countries_target_groups", force: :cascade do |t|
    t.integer "country_id",      limit: 4
    t.integer "target_group_id", limit: 4
  end

  create_table "location_groups", force: :cascade do |t|
    t.string  "name",              limit: 255
    t.integer "country_id",        limit: 4
    t.integer "panel_provider_id", limit: 4
  end

  create_table "location_groups_locations", force: :cascade do |t|
    t.integer "location_id",       limit: 4
    t.integer "location_group_id", limit: 4
  end

  create_table "locations", force: :cascade do |t|
    t.string  "name",        limit: 255
    t.integer "external_id", limit: 4
    t.string  "secret_code", limit: 255
  end

  create_table "panel_providers", force: :cascade do |t|
    t.string "code",    limit: 255
    t.string "pricing", limit: 255
  end

  create_table "target_groups", force: :cascade do |t|
    t.string  "name",              limit: 255
    t.integer "external_id",       limit: 4
    t.integer "parent_id",         limit: 4
    t.string  "secret_code",       limit: 255
    t.integer "panel_provider_id", limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string "name",            limit: 255
    t.string "hashed_password", limit: 255
    t.string "auth_token",      limit: 255
  end

end
