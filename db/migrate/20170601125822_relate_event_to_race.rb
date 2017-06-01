class RelateEventToRace < ActiveRecord::Migration[5.0]
  def change
    add_column :races, :event_id, :integer, null: false, after: :id
    add_index :races, :event_id
  end
end
