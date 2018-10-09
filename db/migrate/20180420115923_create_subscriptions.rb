class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.references :user
      t.references :chat

      t.timestamps
    end
  end
end
