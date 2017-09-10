class CreatePayouts < ActiveRecord::Migration[5.0]
  def change
    create_table :payouts do |t|
      t.integer :race_id,    null: false
      t.integer :bet_type,   null: false
      t.integer :number_1
      t.integer :number_2
      t.integer :number_3
      t.integer :payout,     null: false
      t.integer :popularity, null: false
      t.timestamps

      t.index :race_id
    end
  end
end
