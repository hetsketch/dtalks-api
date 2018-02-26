class AddPriceAndFreeToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :price, :integer, default: 0
    add_column :events, :free, :boolean, default: false
  end
end
