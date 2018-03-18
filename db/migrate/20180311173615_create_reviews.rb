class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.text :text, null: false
      t.belongs_to :user, index: true
      t.belongs_to :company, index: true

      t.timestamps
    end
  end
end
