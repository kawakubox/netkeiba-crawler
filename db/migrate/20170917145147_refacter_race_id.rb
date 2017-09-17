class RefacterRaceId < ActiveRecord::Migration[5.0]
  def up
    execute("UPDATE horse_results SET race_id = '20' || race_id, updated_at = NOW()")
    execute("UPDATE races SET id = '20' || id, key = '20' || key, updated_at = NOW()")
  end

  def down
    execute("UPDATE races SET id = RIGHT(id, 10), key = RIGHT(key, 10), updated_at = NOW()")
    execute("UPDATE horse_results SET race_id = RIGHT(race_id, 10), updated_at = NOW()")
  end
end
