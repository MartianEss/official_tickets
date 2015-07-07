class AddApprovedToUser < ActiveRecord::Migration
  def self.up
    add_column :event_managers, :approved, :boolean, :default => false, :null => false
    add_index  :event_managers, :approved
  end

  def self.down
    remove_index  :event_managers, :approved
    remove_column :event_managers, :approved
  end
end
