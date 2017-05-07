class CreateHorseResults < ActiveRecord::Migration[5.0]
  def change
    create_table :horse_results do |t|
      t.integer :race_id
      t.integer :horse_id
      t.integer :jockey_id
      t.integer :trainer
      t.integer :order
      t.decimal :race_time,     precision: 4, scale: 1
      t.decimal :jockey_weight, precision: 3, scale: 1
      t.integer :horse_weight
      t.integer :weight_diff
      t.integer :gate_number
      t.integer :horse_number
      t.integer :popularity
      t.integer :course_condition
      t.decimal :last_3f,       precision: 3, scale:1
      t.string  :corner_position

      t.timestamps
    end
  end
end
