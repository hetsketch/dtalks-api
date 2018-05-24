class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :text, null: false
      t.datetime :send_at, null: false
      t.references :user
      t.references :chat

      t.timestamps
    end
  end
end
