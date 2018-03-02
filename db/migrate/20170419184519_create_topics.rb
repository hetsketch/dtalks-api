class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics do |t|
      t.string :title, null: false
      t.string :text, null: false
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
