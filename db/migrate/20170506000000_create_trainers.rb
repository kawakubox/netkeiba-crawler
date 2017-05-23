class CreateTrainers < ActiveRecord::Migration[5.0]
  def change
    create_table :trainers do |t|
      t.string :key,   null: false
      t.string :name
      t.integer :area

      t.timestamps

      t.index :key, unique: true
    end
  end
end
