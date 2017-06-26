class AddColumnsOnRaces < ActiveRecord::Migration[5.0]
  def change
    add_column :races, :kind,          :integer
    add_column :races, :course_type,   :integer
    add_column :races, :direction,     :integer
    add_column :races, :circumference, :integer
  end
end
