class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :key
      t.date   :held_on
      t.string :name

      t.timestamps

      t.index :key, unique: true
    end
  end
end
