class AddUserToTopic < ActiveRecord::Migration[5.0]
  def change
    add_reference :topics, :user, index: true
  end
end
