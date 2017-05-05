class CreateHorses < ActiveRecord::Migration[5.0]
  def change
    create_table :horses do |t|
      t.string :key
      t.string :name
      t.date :birthday

      t.timestamps

      t.index :key
    end
  end
end
