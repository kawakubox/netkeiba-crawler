class AddColumnsOnHorse < ActiveRecord::Migration[5.0]
  def change
    add_column :horses, :sex,        :integer
    add_column :horses, :body_color, :string
    add_column :horses, :sire_id,    :integer
    add_column :horses, :mare_id,    :integer
    add_column :horses, :trainer_id, :integer
    add_column :horses, :owner,      :string
    add_column :horses, :breeder,    :string
    add_column :horses, :birthplace, :string

    add_index :horses, :sire_id
    add_index :horses, :mare_id
    add_index :horses, :trainer_id
  end
end
