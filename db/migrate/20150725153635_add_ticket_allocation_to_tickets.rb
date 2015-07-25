class AddTicketAllocationToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :tickets_allocation_id, :integer, null: false
  end
end
