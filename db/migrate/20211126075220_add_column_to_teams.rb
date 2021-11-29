class AddColumnToTeams < ActiveRecord::Migration[6.1]
  def change
    add_column :teams, :description, :text
    add_index :teams, [:name, :sub_category_id], unique: true
  end
end
