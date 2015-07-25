class AddNameOnTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :ordered_for, :string, null: false, default: ''
  end
end
