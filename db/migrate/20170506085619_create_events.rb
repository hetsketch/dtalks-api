class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :title
      t.string :text
      t.datetime :event_date
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
