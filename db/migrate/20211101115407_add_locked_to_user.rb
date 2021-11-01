class AddLockedToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :locked_at, :datetime
    add_column :users, :failed_attempts, :integer
  end
end
