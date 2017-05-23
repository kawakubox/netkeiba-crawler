class CreateHorses < ActiveRecord::Migration[5.0]
  def change
    create_table :horses do |t|
      t.string :key,      null: false
      t.string :name
      t.date   :birthday

      t.timestamps

      t.index :key, unique: true
    end
  end
end
