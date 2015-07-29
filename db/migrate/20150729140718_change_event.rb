class ChangeEvent < ActiveRecord::Migration
  def change
    add_column :events, :venue, :string

    remove_column :events, :venue_id, :string
  end
end
