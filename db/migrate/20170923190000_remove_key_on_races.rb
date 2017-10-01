class RemoveKeyOnRaces < ActiveRecord::Migration[5.0]
  def up
    remove_column :races, :key
  end

  def down
    add_column :races, :key, :string
    execute('UPDATE races SET key = id')
  end
end
