class CreateTrainers < ActiveRecord::Migration[5.0]
  def change
    create_table :trainers do |t|
      t.string :key
      t.string :name
      t.integer :area

      t.timestamps
    end
  end
end
