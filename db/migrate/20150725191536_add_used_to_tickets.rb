class AddUsedToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :used, :boolean, default: false, null: false
  end
end
