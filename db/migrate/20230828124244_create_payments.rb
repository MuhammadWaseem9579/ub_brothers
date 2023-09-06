class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.string :voucher_no, null: false
      t.string :reference
      t.text :description, null: false
      t.string :cheque_no
      t.decimal :debit, precision: 12, scale: 2, default: 0, null: false
      t.decimal :credit, precision: 12, scale: 2, default: 0, null: false
      t.date :payment_date, null: false
      t.datetime :deleted_at
      t.references :user, foreign_key: true
      t.references :party, foreign_key: true
      
      t.timestamps
    end
  end
end
