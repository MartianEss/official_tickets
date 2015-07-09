class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :serial

      t.belongs_to :order
      t.belongs_to :event

      t.timestamps null: false
    end
  end
end
