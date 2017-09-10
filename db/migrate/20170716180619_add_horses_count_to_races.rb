class AddHorsesCountToRaces < ActiveRecord::Migration
  def self.up
    add_column :races, :horses_count, :integer, :null => false, :default => 0
  end

  def self.down
    remove_column :races, :horses_count
  end
end
