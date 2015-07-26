class AddTransactionIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :transaction_code, :string
  end
end
