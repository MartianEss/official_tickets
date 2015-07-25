class AddVenueToEvent < ActiveRecord::Migration
  def change
    add_column :events, :venue, :string, null: false, default: ''
  end
end
