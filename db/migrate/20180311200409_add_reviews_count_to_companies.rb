class AddReviewsCountToCompanies < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :reviews_count, :integer, default: 0
  end
end
