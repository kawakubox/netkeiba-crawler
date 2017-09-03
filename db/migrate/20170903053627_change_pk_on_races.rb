class ChangePkOnRaces < ActiveRecord::Migration[5.0]
  def change
    # Drop materialized view
    execute('DROP MATERIALIZED VIEW race_entries')

    # horse_results.race_id 型変更
    change_column :horse_results, :race_id, :string

    # horse_results.race_id 更新
	  execute('UPDATE horse_results SET race_id = races.key FROM races WHERE race_id = CAST(races.id AS VARCHAR(10))')

    # races.id 型変更
    change_column :races, :id, :string

    # horses.id を horses.key の値で更新
    execute('UPDATE races SET id = "key"')

    # Materialized view を再作成
    sql = <<~SQL
            CREATE MATERIALIZED VIEW race_entries AS
              SELECT
                r.id            AS race_id,
                hr.gate_number  AS gate_number,
                hr.horse_number AS horse_number,
                h.id            AS horse_id,
                hr1.id          AS result_1_id,
                hr2.id          AS result_2_id,
                hr3.id          AS result_3_id,
                hr4.id          AS result_4_id,
                hr5.id          AS result_5_id
              FROM races r
                INNER JOIN horse_results hr ON r.id = hr.race_id
                INNER JOIN horses h ON hr.horse_id = h.id
                LEFT OUTER JOIN horse_results hr1 ON hr1.horse_id = h.id AND hr1.order_of_race = hr.order_of_race - 1
                LEFT OUTER JOIN horse_results hr2 ON hr2.horse_id = h.id AND hr2.order_of_race = hr.order_of_race - 2
                LEFT OUTER JOIN horse_results hr3 ON hr3.horse_id = h.id AND hr3.order_of_race = hr.order_of_race - 3
                LEFT OUTER JOIN horse_results hr4 ON hr4.horse_id = h.id AND hr4.order_of_race = hr.order_of_race - 4
                LEFT OUTER JOIN horse_results hr5 ON hr5.horse_id = h.id AND hr5.order_of_race = hr.order_of_race - 5
              ORDER BY
                race_id,
                horse_number
          SQL
    execute(sql)
  end
end
