class RemoveKeyOnEvents < ActiveRecord::Migration[5.0]
  def up
    remove_column :events, :key
  end

  def down
    add_column :events, :key, :string
    execute('UPDATE events SET key = id')
  end
end
