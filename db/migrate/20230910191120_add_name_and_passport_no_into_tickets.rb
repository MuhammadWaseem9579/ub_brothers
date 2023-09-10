class AddNameAndPassportNoIntoTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :name, :string, null: false
    add_column :tickets, :passport_no, :string, null: false
    add_column :tickets, :refunded, :boolean, default: false
  end
end
