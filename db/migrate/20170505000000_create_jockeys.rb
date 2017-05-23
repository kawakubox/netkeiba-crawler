class CreateJockeys < ActiveRecord::Migration[5.0]
  def change
    create_table :jockeys do |t|
      t.string :key,  null: false
      t.string :name

      t.timestamps

      t.index :key, unique: true
    end
  end
end
