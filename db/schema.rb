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

ActiveRecord::Schema.define(version: 20161222043216) do

  create_table "companies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "status",     default: 1
    t.datetime "deleted_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "company_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "cutoff_date"
    t.string   "timezone"
    t.integer  "company_id"
    t.datetime "deleted_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["company_id"], name: "index_company_settings_on_company_id", using: :btree
  end

  create_table "compensations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "from"
    t.datetime "to"
    t.integer  "status"
    t.integer  "type"
    t.integer  "request_leave_id"
    t.datetime "deleted_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["request_leave_id"], name: "index_compensations_on_request_leave_id", using: :btree
  end

  create_table "dayoff_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "company_id"
    t.integer  "loop_available",   default: 1
    t.integer  "limmit_loop_year"
    t.integer  "limmit_loop_day"
    t.datetime "deleted_at"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["company_id"], name: "index_dayoff_settings_on_company_id", using: :btree
  end

  create_table "groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "company_id"
    t.string   "name"
    t.text     "description",       limit: 65535
    t.integer  "closest_parent_id"
    t.string   "parent_path"
    t.integer  "group_type"
    t.datetime "deleted_at"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["company_id"], name: "index_groups_on_company_id", using: :btree
  end

  create_table "holidays", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "type"
    t.date     "date"
    t.integer  "company_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_holidays_on_company_id", using: :btree
  end

  create_table "leave_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.float    "amount",      limit: 24
    t.integer  "unit"
    t.integer  "limit_times"
    t.integer  "company_id"
    t.datetime "deleted_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["company_id"], name: "index_leave_settings_on_company_id", using: :btree
  end

  create_table "leave_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "description"
    t.string   "code"
    t.datetime "deleted_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "location_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "color"
    t.integer  "default_width",  default: 200
    t.integer  "default_height", default: 200
    t.datetime "deleted_at"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "locations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "location_type_id"
    t.integer  "user_id"
    t.integer  "pos_x"
    t.integer  "pos_y"
    t.integer  "width"
    t.integer  "height"
    t.string   "section_key"
    t.integer  "workspace_id"
    t.string   "location_key"
    t.datetime "deleted_at"
    t.index ["location_type_id"], name: "index_locations_on_location_type_id", using: :btree
    t.index ["user_id"], name: "index_locations_on_user_id", using: :btree
  end

  create_table "normal_dayoff_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "operator"
    t.integer  "years"
    t.integer  "count_day"
    t.integer  "dayoff_setting_id"
    t.datetime "deleted_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["dayoff_setting_id"], name: "index_normal_dayoff_settings_on_dayoff_setting_id", using: :btree
  end

  create_table "ot_detail_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "ot_setting_id"
    t.time     "from_time"
    t.time     "end_time"
    t.integer  "wage_rate"
    t.datetime "deleted_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["ot_setting_id"], name: "index_ot_detail_settings_on_ot_setting_id", using: :btree
  end

  create_table "ot_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "company_id"
    t.time     "from_time_available"
    t.time     "end_time_available"
    t.datetime "deleted_at"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["company_id"], name: "index_ot_settings_on_company_id", using: :btree
  end

  create_table "permissions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "entry"
    t.string   "optional"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "personal_issues", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "phone_number"
    t.string   "address_contact"
    t.datetime "off_no_salary_from"
    t.datetime "off_no_salary_to"
    t.string   "reason"
    t.integer  "user_id"
    t.integer  "company_id"
    t.integer  "user_handover"
    t.string   "part_handover"
    t.string   "work_handover"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "positions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "project_members", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.integer  "role_scrum", default: 2
    t.datetime "deleted_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["project_id"], name: "index_project_members_on_project_id", using: :btree
    t.index ["user_id"], name: "index_project_members_on_user_id", using: :btree
  end

  create_table "projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "request_leaves", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "leave_from"
    t.datetime "leave_to"
    t.string   "reason"
    t.integer  "status",        default: 0
    t.integer  "approve_group"
    t.integer  "leave_type_id"
    t.integer  "user_id"
    t.datetime "deleted_at"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["leave_type_id"], name: "index_request_leaves_on_leave_type_id", using: :btree
    t.index ["user_id"], name: "index_request_leaves_on_user_id", using: :btree
  end

  create_table "request_offs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date     "request_date"
    t.string   "project_name"
    t.string   "position_name"
    t.string   "department"
    t.string   "phone_number"
    t.string   "address_contact"
    t.datetime "off_have_salary_from"
    t.datetime "off_have_salary_to"
    t.integer  "special_dayoff_setting_id"
    t.datetime "off_no_salary_from"
    t.datetime "off_no_salary_to"
    t.string   "reason"
    t.integer  "special_dayoff_type_id"
    t.integer  "user_handover"
    t.string   "part_handover"
    t.string   "work_handover"
    t.integer  "status"
    t.integer  "approver_id"
    t.integer  "user_id"
    t.datetime "deleted_at"
    t.integer  "company_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["approver_id"], name: "index_request_offs_on_approver_id", using: :btree
    t.index ["special_dayoff_setting_id"], name: "index_request_offs_on_special_dayoff_setting_id", using: :btree
    t.index ["special_dayoff_type_id"], name: "index_request_offs_on_special_dayoff_type_id", using: :btree
    t.index ["user_id"], name: "index_request_offs_on_user_id", using: :btree
  end

  create_table "request_ots", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.time     "from_time"
    t.time     "end_time"
    t.string   "phone_number"
    t.string   "reason"
    t.integer  "status"
    t.integer  "user_id"
    t.integer  "approve_group"
    t.datetime "deleted_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["user_id"], name: "index_request_ots_on_user_id", using: :btree
  end

  create_table "sections", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "workspace_id"
    t.string   "name"
    t.integer  "pos_x"
    t.integer  "pos_y"
    t.integer  "width"
    t.integer  "height"
    t.string   "section_key"
    t.datetime "deleted_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["workspace_id"], name: "index_sections_on_workspace_id", using: :btree
  end

  create_table "shifts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "company_id"
    t.time     "time_in"
    t.time     "time_out"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_shifts_on_company_id", using: :btree
  end

  create_table "special_dayoff_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "dayoff_setting_id"
    t.integer  "amount"
    t.integer  "special_dayoff_type_id"
    t.integer  "unit"
    t.integer  "limit_times"
    t.integer  "loop_type"
    t.datetime "deleted_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["dayoff_setting_id"], name: "index_special_dayoff_settings_on_dayoff_setting_id", using: :btree
    t.index ["special_dayoff_type_id"], name: "index_special_dayoff_settings_on_special_dayoff_type_id", using: :btree
  end

  create_table "special_dayoff_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "description", limit: 65535
    t.string   "code"
    t.datetime "deleted_at"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "time_sheets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date     "date"
    t.time     "time_in"
    t.time     "time_out"
    t.integer  "type"
    t.datetime "deleted_at"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_time_sheets_on_user_id", using: :btree
  end

  create_table "timesheet_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "layout_type"
    t.integer  "value_type"
    t.string   "optional_settings"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "start_row_data"
    t.string   "date_format_type",  default: "%d/%m/%Y"
    t.datetime "deleted_at"
    t.integer  "company_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["company_id"], name: "index_timesheet_settings_on_company_id", using: :btree
  end

  create_table "user_dayoffs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "special_dayoff_type_id"
    t.date     "init_date"
    t.float    "remain",                 limit: 24
    t.datetime "deleted_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["special_dayoff_type_id"], name: "index_user_dayoffs_on_special_dayoff_type_id", using: :btree
    t.index ["user_id"], name: "index_user_dayoffs_on_user_id", using: :btree
  end

  create_table "user_groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_user_groups_on_group_id", using: :btree
    t.index ["user_id"], name: "index_user_groups_on_user_id", using: :btree
  end

  create_table "user_leaves", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.float    "remain",     limit: 24
    t.datetime "deleted_at"
    t.integer  "user_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["user_id"], name: "index_user_leaves_on_user_id", using: :btree
  end

  create_table "user_workspaces", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "workspace_id"
    t.integer  "user_id"
    t.boolean  "is_manager",   default: false
    t.datetime "deleted_at"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["user_id"], name: "index_user_workspaces_on_user_id", using: :btree
    t.index ["workspace_id"], name: "index_user_workspaces_on_workspace_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "gender"
    t.integer  "role",                   default: 2
    t.datetime "birthday"
    t.string   "employee_code"
    t.integer  "position_id"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "deleted_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "title"
    t.string   "avatar"
    t.integer  "company_id"
    t.index ["company_id"], name: "index_users_on_company_id", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "workspaces", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "description"
    t.string   "image"
    t.boolean  "status",      default: false
    t.integer  "user_id"
    t.datetime "deleted_at"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["user_id"], name: "index_workspaces_on_user_id", using: :btree
  end

  add_foreign_key "company_settings", "companies"
  add_foreign_key "compensations", "request_leaves"
  add_foreign_key "dayoff_settings", "companies"
  add_foreign_key "groups", "companies"
  add_foreign_key "holidays", "companies"
  add_foreign_key "leave_settings", "companies"
  add_foreign_key "locations", "location_types"
  add_foreign_key "locations", "users"
  add_foreign_key "normal_dayoff_settings", "dayoff_settings"
  add_foreign_key "ot_detail_settings", "ot_settings"
  add_foreign_key "ot_settings", "companies"
  add_foreign_key "project_members", "projects"
  add_foreign_key "project_members", "users"
  add_foreign_key "request_leaves", "leave_types"
  add_foreign_key "request_leaves", "users"
  add_foreign_key "request_offs", "special_dayoff_settings"
  add_foreign_key "request_offs", "special_dayoff_types"
  add_foreign_key "request_offs", "users"
  add_foreign_key "request_ots", "users"
  add_foreign_key "sections", "workspaces"
  add_foreign_key "shifts", "companies"
  add_foreign_key "special_dayoff_settings", "dayoff_settings"
  add_foreign_key "special_dayoff_settings", "special_dayoff_types"
  add_foreign_key "time_sheets", "users"
  add_foreign_key "timesheet_settings", "companies"
  add_foreign_key "user_dayoffs", "special_dayoff_types"
  add_foreign_key "user_dayoffs", "users"
  add_foreign_key "user_groups", "groups"
  add_foreign_key "user_groups", "users"
  add_foreign_key "user_leaves", "users"
  add_foreign_key "user_workspaces", "users"
  add_foreign_key "user_workspaces", "workspaces"
  add_foreign_key "users", "companies"
  add_foreign_key "workspaces", "users"
end
