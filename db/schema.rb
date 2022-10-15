# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_10_15_161113) do
  create_table "account_balances", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "accounting_transaction_id", null: false
    t.decimal "change", precision: 10, scale: 4, null: false
    t.decimal "total", precision: 10, scale: 4, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accounting_transaction_id"], name: "index_account_balances_on_accounting_transaction_id"
    t.index ["user_id"], name: "index_account_balances_on_user_id"
  end

  create_table "accounting_transactions", force: :cascade do |t|
    t.integer "debit_account_id"
    t.integer "credit_account_id"
    t.datetime "date", null: false
    t.decimal "amount", precision: 10, scale: 4, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["credit_account_id"], name: "index_accounting_transactions_on_credit_account_id"
    t.index ["debit_account_id"], name: "index_accounting_transactions_on_debit_account_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "account_balances", "accounting_transactions"
  add_foreign_key "account_balances", "users"
  add_foreign_key "accounting_transactions", "users", column: "credit_account_id"
  add_foreign_key "accounting_transactions", "users", column: "debit_account_id"
end
