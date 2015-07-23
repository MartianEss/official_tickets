class AddTicketIdToTicketPurchaser < ActiveRecord::Migration
  def change
    add_column :tickets, :ticket_purchaser_id, :integer
  end
end
