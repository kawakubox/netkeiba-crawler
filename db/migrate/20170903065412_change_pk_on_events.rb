class ChangePkOnEvents < ActiveRecord::Migration[5.0]
  def change
    # races.event_id 型変更
    change_column :races, :event_id, :string

    # races.event_id 更新
    execute('UPDATE races SET event_id = events.key FROM events WHERE event_id = CAST(events.id AS VARCHAR(10))')

    # events.id 型変更
    change_column :events, :id, :string

    # events.id を events.key の値で更新
    execute('UPDATE events SET id = "key"')
  end
end
