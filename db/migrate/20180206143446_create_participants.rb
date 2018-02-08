class CreateParticipants < ActiveRecord::Migration[5.1]
  def change
    create_table :participants do |t|
      t.references :user, foreign_key: true, index: true
      t.references :event, foreign_key: true, index: true

      t.timestamps
    end
  end
end
