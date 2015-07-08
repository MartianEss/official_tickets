class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title, index: true
      t.string :description
      t.string :location
      t.string :genre
      t.string :dress_code
      t.date :date_from
      t.date :date_to
      t.time :time_to
      t.time :time_from
      t.string :contact_number
      t.string :ticket_type
      t.float :price
      t.integer :tickets_allocated
      t.boolean :approved, default: false

      t.timestamps null: false

      t.belongs_to :event_manager, index: true
    end
  end
end
