class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.string :invoice_no, null: false
      t.string :ticket_no, null: false
      t.string :sector, null: false
      t.decimal :fare, precision: 12, scale: 2, default: 0, null: false
      t.decimal :taxes, precision: 12, scale: 2, default: 0, null: false
      t.decimal :sp, precision: 12, scale: 2, default: 0, null: false
      t.decimal :kb, precision: 12, scale: 2, default: 0, null: false
      t.references :user, foreign_key: true
      t.references :party, foreign_key: true

      t.timestamps
    end
  end
end
