class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :avatar, :text
    add_column :users, :name, :string
  end
end
