class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :number_of_tickets

      t.belongs_to :ticket_purchaser
      t.belongs_to :event

      t.timestamps null: false
    end
  end
end
