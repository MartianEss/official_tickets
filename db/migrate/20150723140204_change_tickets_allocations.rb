class ChangeTicketsAllocations < ActiveRecord::Migration
  def change
    add_column :tickets_allocations, :order_id, :integer
  end
end
