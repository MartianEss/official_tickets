class RemoveTicketFieldsFromEvent < ActiveRecord::Migration
  def change
    remove_column :events, :ticket_type
    remove_column :events, :tickets_allocated
    remove_column :events, :price
  end
end
