class CreateTicketsAllocations < ActiveRecord::Migration
  def change
    create_table :tickets_allocations do |t|
      t.string :name, null: false
      t.float :price, null: false
      t.integer :allocated, null: false, default: 0

      t.belongs_to :event_manager
      t.belongs_to :event

      t.timestamps null: false
    end
  end
end
