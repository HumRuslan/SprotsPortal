class AddExtServiceToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :ext_service, :boolean, default: false
  end
end
