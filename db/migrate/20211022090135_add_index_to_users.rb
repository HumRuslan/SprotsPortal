class AddIndexToUsers < ActiveRecord::Migration[6.1]
  def change
    add_index :users, :email
    add_index :users, [:first_name, :last_name]
  end
end
