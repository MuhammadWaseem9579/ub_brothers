# frozen_string_literal: true

class CreateParties < ActiveRecord::Migration[7.0]
  def change
    create_table :parties do |t|
      t.string :name, null: false
      t.decimal :opening_balance, precision: 12, scale: 2, default: 0, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
