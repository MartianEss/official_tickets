class AddEventType < ActiveRecord::Migration
  def change
    add_column :events, :event_type_id, :integer
    add_column :events, :dress_code_id, :integer
    add_column :events, :genre_id, :integer

    remove_column :events, :genre
    remove_column :events, :dress_code
  end
end
