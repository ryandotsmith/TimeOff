# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100529163700) do

  create_table "accounts", :force => true do |t|
    t.string   "company_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
  end

  create_table "daysoff", :force => true do |t|
    t.integer  "user_id"
    t.integer  "state",        :default => 0
    t.string   "reviewed_by"
    t.datetime "reviewed_on"
    t.datetime "begin_time"
    t.datetime "end_time"
    t.string   "leave_type"
    t.text     "description"
    t.string   "leave_length"
    t.string   "action_notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
  end

  create_table "users", :force => true do |t|
    t.integer  "account_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                               :null => false
    t.string   "crypted_password",                    :null => false
    t.string   "password_salt",                       :null => false
    t.string   "persistence_token",                   :null => false
    t.string   "single_access_token",                 :null => false
    t.string   "perishable_token",                    :null => false
    t.integer  "login_count",         :default => 0,  :null => false
    t.integer  "failed_login_count",  :default => 0,  :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "max_etc",             :default => 10
    t.integer  "max_personal",        :default => 10
    t.integer  "max_vacation",        :default => 10
  end

end
