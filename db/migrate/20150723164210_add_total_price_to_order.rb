class AddTotalPriceToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :total_price, :float, default: 0, null: false
  end
end
