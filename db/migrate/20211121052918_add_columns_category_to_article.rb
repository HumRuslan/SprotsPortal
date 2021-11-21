class AddColumnsCategoryToArticle < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :team_id, :bigint

    add_foreign_key :articles, :teams, dependent: :delete
  end
end
