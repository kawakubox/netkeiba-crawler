class CreatePayouts < ActiveRecord::Migration[5.0]
  def change
    create_table :payouts do |t|

      t.timestamps
    end
  end
end
