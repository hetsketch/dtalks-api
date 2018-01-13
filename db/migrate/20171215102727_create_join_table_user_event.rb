# frozen_string_literal: true

class CreateJoinTableUserEvent < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :events do |t|
      t.index [:user_id, :event_id]
    end
  end
end
