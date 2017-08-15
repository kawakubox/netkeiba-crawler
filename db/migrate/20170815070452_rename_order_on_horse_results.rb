class RenameOrderOnHorseResults < ActiveRecord::Migration[5.0]
  def change
    rename_column :horse_results, :order, :order_of_finish
  end
end
