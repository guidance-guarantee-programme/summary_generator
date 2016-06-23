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

ActiveRecord::Schema.define(version: 20160622152919) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointment_summaries", force: :cascade do |t|
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "address_line_3"
    t.string   "town"
    t.string   "county"
    t.string   "postcode"
    t.string   "title"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "country",                                default: "United Kingdom"
    t.date     "date_of_appointment"
    t.string   "appointment_type",                       default: "standard"
    t.string   "guider_name"
    t.string   "guider_organisation"
    t.string   "has_defined_contribution_pension"
    t.boolean  "supplementary_benefits"
    t.boolean  "supplementary_debt"
    t.boolean  "supplementary_ill_health"
    t.boolean  "supplementary_defined_benefit_pensions"
    t.string   "format_preference",                      default: "standard"
    t.integer  "user_id"
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
  end

  add_index "appointment_summaries", ["user_id"], name: "index_appointment_summaries_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "uid"
    t.string   "organisation_slug"
    t.string   "organisation_content_id"
    t.string   "permissions"
    t.boolean  "remotely_signed_out",     default: false
    t.boolean  "disabled",                default: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

end
