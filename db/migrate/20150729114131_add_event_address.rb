class AddEventAddress < ActiveRecord::Migration
  def change
    add_column :events, :address_line1, :string
    add_column :events, :address_line2, :string
    add_column :events, :town_city, :string
    add_column :events, :post_code, :string

    remove_column :events, :location
  end
end
