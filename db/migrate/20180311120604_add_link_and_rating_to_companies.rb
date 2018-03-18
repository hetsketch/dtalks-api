class AddLinkAndRatingToCompanies < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :url, :string
    add_column :companies, :rating, :float, null: false, default: 0.0
  end
end
