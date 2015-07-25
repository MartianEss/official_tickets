class AddNamesOnTicketToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :names_on_ticket, :string, null: false, default: ''
  end
end
