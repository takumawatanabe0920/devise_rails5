class AddColumnToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :name, :string
  end
end
