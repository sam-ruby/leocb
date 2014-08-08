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

ActiveRecord::Schema.define(version: 20140808044646) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "entries"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["name"], name: "category_name_index", unique: true, using: :btree

  create_table "companies", force: true do |t|
    t.integer  "sector_id"
    t.integer  "company_id"
    t.string   "website"
    t.date     "start_date"
    t.string   "location"
    t.string   "status"
    t.string   "stage"
    t.string   "tags"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "companies", ["company_id", "name"], name: "company_name_company_id_index", unique: true, using: :btree

  create_table "investors", force: true do |t|
    t.integer  "company_id"
    t.date     "investment_period"
    t.string   "name"
    t.decimal  "investment_amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "investors", ["company_id"], name: "investors_company_id_index", using: :btree

  create_table "mile_stones", force: true do |t|
    t.integer  "company_id"
    t.text     "name"
    t.date     "milestone_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mile_stones", ["company_id"], name: "mile_stones_company_id_index", using: :btree

  create_table "persons", force: true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.string   "photo_url"
    t.string   "blog_url"
    t.string   "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "persons", ["company_id"], name: "persons_company_id_index", using: :btree

  create_table "products", force: true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["company_id"], name: "products_company_id_index", using: :btree

  create_table "sam", id: false, force: true do |t|
    t.string "name", limit: 100
  end

  create_table "sectors", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sectors", ["name"], name: "sector_name_index", unique: true, using: :btree

end
