class CreateRaces < ActiveRecord::Migration[5.0]
  def change
    create_table :races do |t|
      t.string  :key,              null: false
      t.integer :ordinal
      t.string  :name
      t.integer :grade
      t.integer :distance
      t.integer :weather
      t.integer :course_condition

      t.timestamps

      t.index :key, unique: true
    end
  end
end
