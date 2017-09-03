class ChangePkOnJockeys < ActiveRecord::Migration[5.0]
  def change
    # horse_results.jockey_id 型変更
    change_column :horse_results, :jockey_id, :string

    # horse_results.jockey_id 更新
    execute('UPDATE horse_results SET jockey_id = jockeys.key FROM jockeys WHERE jockey_id = CAST(jockeys.id AS VARCHAR(10))')

    # jockeys.id 型変更
    change_column :jockeys, :id, :string

    # horses.id を horses.key の値で更新
    execute('UPDATE jockeys SET id = "key"')
  end
end
