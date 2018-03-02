class AddCounterCaches < ActiveRecord::Migration[5.1]
  def change
    add_column :topics, :impressions_count, :integer, default: 0
    add_column :topics, :comments_count, :integer, default: 0
    add_column :events, :impressions_count, :integer, default: 0
    add_column :events, :participants_count, :integer, default: 0
    add_column :companies, :employees_count, :integer, default: 0
  end
end
