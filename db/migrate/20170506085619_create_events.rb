class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :title
      t.string :text
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.belongs_to :user, index: true
      t.text :image_data
      t.integer :price, default: 0
      t.boolean :free, default: false
      t.boolean :online, default: false
      t.string :city
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
