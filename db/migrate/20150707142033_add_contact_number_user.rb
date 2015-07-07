class AddContactNumberUser < ActiveRecord::Migration
  def self.up
    add_column :event_managers, :contact_number, :string, :default => false, :null => false
  end

  def self.down
    remove_column :event_managers, :contact_number
  end
end
