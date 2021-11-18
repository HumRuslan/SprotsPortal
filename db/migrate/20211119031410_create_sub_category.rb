class CreateSubCategory < ActiveRecord::Migration[6.1]
  def change
    create_table :sub_categories do |t|
      t.string :name
      t.bigint :category_id

      t.timestamps
    end

    add_foreign_key :sub_categories, :categories, dependent: :delete
  end
end
