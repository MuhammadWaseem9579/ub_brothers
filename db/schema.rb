# frozen_string_literal: true

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

ActiveRecord::Schema[7.0].define(version: 20_230_828_124_244) do
  create_table 'parties', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.string 'name', null: false
    t.decimal 'opening_balance', precision: 12, scale: 2, default: '0.0', null: false
    t.bigint 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.datetime 'deleted_at'
    t.index ['deleted_at'], name: 'index_parties_on_deleted_at'
    t.index ['user_id'], name: 'index_parties_on_user_id'
  end

  create_table 'payments', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.string 'voucher_no', null: false
    t.string 'reference'
    t.text 'description', null: false
    t.string 'cheque_no'
    t.decimal 'debit', precision: 12, scale: 2, default: '0.0', null: false
    t.decimal 'credit', precision: 12, scale: 2, default: '0.0', null: false
    t.date 'payment_date', null: false
    t.datetime 'deleted_at'
    t.bigint 'user_id'
    t.bigint 'party_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['party_id'], name: 'index_payments_on_party_id'
    t.index ['user_id'], name: 'index_payments_on_user_id'
  end

  create_table 'tickets', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.string 'invoice_no', null: false
    t.string 'ticket_no', null: false
    t.string 'sector', null: false
    t.decimal 'fare', precision: 12, scale: 2, default: '0.0', null: false
    t.decimal 'taxes', precision: 12, scale: 2, default: '0.0', null: false
    t.decimal 'sp', precision: 12, scale: 2, default: '0.0', null: false
    t.decimal 'kb', precision: 12, scale: 2, default: '0.0', null: false
    t.date 'ticket_date', null: false
    t.bigint 'user_id'
    t.bigint 'party_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.datetime 'deleted_at'
    t.index ['deleted_at'], name: 'index_tickets_on_deleted_at'
    t.index ['party_id'], name: 'index_tickets_on_party_id'
    t.index ['user_id'], name: 'index_tickets_on_user_id'
  end

  create_table 'users', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.string 'first_name', default: '', null: false
    t.string 'last_name', default: '', null: false
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.datetime 'deleted_at'
    t.index ['deleted_at'], name: 'index_users_on_deleted_at'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'parties', 'users'
  add_foreign_key 'payments', 'parties'
  add_foreign_key 'payments', 'users'
  add_foreign_key 'tickets', 'parties'
  add_foreign_key 'tickets', 'users'
end
