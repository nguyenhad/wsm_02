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

ActiveRecord::Schema.define(version: 20161130013356) do

  create_table "position_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name"
    t.string  "color"
    t.integer "default_width",  default: 200
    t.integer "default_height", default: 200
  end

  create_table "positions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "section_id"
    t.integer "position_type_id"
    t.integer "user_id"
    t.integer "pos_x"
    t.integer "pos_y"
    t.integer "width"
    t.integer "height"
    t.string  "position_key"
    t.index ["position_type_id"], name: "index_positions_on_position_type_id", using: :btree
    t.index ["section_id"], name: "index_positions_on_section_id", using: :btree
    t.index ["user_id"], name: "index_positions_on_user_id", using: :btree
  end

  create_table "project_members", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.integer  "role_scrum", default: 2
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["project_id"], name: "index_project_members_on_project_id", using: :btree
    t.index ["user_id"], name: "index_project_members_on_user_id", using: :btree
  end

  create_table "projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sections", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "workspace_id"
    t.string  "name"
    t.integer "pos_x"
    t.integer "pos_y"
    t.integer "width"
    t.integer "height"
    t.index ["workspace_id"], name: "index_sections_on_workspace_id", using: :btree
  end

  create_table "time_sheets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "employee_code"
    t.datetime "date"
    t.string   "time_in"
    t.string   "time_out"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "user_workspaces", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "workspace_id"
    t.integer "user_id"
    t.boolean "is_manager",   default: false
    t.index ["user_id"], name: "index_user_workspaces_on_user_id", using: :btree
    t.index ["workspace_id"], name: "index_user_workspaces_on_workspace_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "gender"
    t.integer  "role",                   default: 2
    t.datetime "birthday"
    t.string   "employee_code"
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "title"
    t.string   "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "workspaces", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name"
    t.string  "description"
    t.string  "image"
    t.boolean "status",      default: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_workspaces_on_user_id", using: :btree
  end

  add_foreign_key "positions", "position_types"
  add_foreign_key "positions", "sections"
  add_foreign_key "positions", "users"
  add_foreign_key "project_members", "projects"
  add_foreign_key "project_members", "users"
  add_foreign_key "sections", "workspaces"
  add_foreign_key "user_workspaces", "users"
  add_foreign_key "user_workspaces", "workspaces"
  add_foreign_key "workspaces", "users"
end
