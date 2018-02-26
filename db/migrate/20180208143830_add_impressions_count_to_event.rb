class AddImpressionsCountToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :impressions_count, :integer, default: 0
  end
end
