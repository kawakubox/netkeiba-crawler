class CreateJockeys < ActiveRecord::Migration[5.0]
  def change
    create_table :jockeys do |t|
      t.string :key
      t.string :name

      t.timestamps
    end
  end
end
