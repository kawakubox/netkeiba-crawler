class CreateRaceNames < ActiveRecord::Migration[5.0]
  def change
    create_table :race_names do |t|
      t.string :long_name,  null: false
      t.string :short_name, null: false

      t.timestamps

      t.index :long_name, unique: true
      t.index :short_name, unique: true
    end

    add_column :races, :race_name_id, :integer
    add_index :races, :race_name_id
  end
end
