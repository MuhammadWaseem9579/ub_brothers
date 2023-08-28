class AddDeletedAtToParanoiac < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :deleted_at, :datetime
    add_column :parties, :deleted_at, :datetime
    add_column :tickets, :deleted_at, :datetime
    add_index :users, :deleted_at
    add_index :parties, :deleted_at
    add_index :tickets, :deleted_at
  end
end
