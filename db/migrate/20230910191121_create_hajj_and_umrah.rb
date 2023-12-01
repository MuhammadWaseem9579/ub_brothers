class CreateHajjAndUmrah < ActiveRecord::Migration[7.0]
  def change
    create_table :hajj_and_umrahs do |t|
      t.text :description, null: false
      t.date :entry_date, null: false
      t.string :voucher_no, null: false
      t.decimal :visa_rate, precision: 12, scale: 2, default: 0, null: false
      t.decimal :makkah_hotel_amount, precision: 12, scale: 2, default: 0, null: false
      t.decimal :madina_hotel_amount, precision: 12, scale: 2, default: 0, null: false
      t.datetime :deleted_at
      t.references :user, foreign_key: true
      t.references :party, foreign_key: true

      t.timestamps
    end
  end
end
