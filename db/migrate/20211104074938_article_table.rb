class ArticleTable < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :headline
      t.string :alt_picture
      t.string :caption
      t.text :content
      t.integer :comment, limit: 1, default: 0
      t.integer :published, limit: 1, default: 0
      t.string :picture
    end
    add_index :articles, :headline
  end
end
