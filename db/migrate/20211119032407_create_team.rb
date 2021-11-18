class CreateTeam < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.bigint :category_id
      t.bigint :sub_category_id

      t.timestamps
    end

    add_foreign_key :teams, :sub_categories, dependent: :delete
    add_foreign_key :teams, :categories, dependent: :delete
  end
end
