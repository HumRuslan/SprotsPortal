class AddTimestampsToArticle < ActiveRecord::Migration[6.1]
  def change
    add_timestamps :articles
  end
end
