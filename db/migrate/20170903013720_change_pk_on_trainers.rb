class ChangePkOnTrainers < ActiveRecord::Migration[5.0]
  def change
    # horse_results.trainer_id 型変更
    change_column :horse_results, :trainer_id, :string

    # horse_results.trainer_id 更新
    execute('UPDATE horse_results SET trainer_id = trainers.key FROM trainers WHERE trainer_id = CAST(trainers.id AS VARCHAR(10))')

    # trainers.id 型変更
    change_column :trainers, :id, :string

    # trainers.id を trainers.key の値で更新
    execute('UPDATE trainers SET id = "key"')
  end
end
