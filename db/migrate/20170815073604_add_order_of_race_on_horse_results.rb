class AddOrderOfRaceOnHorseResults < ActiveRecord::Migration[5.0]
  def change
    add_column :horse_results, :order_of_race, :integer
  end
end
