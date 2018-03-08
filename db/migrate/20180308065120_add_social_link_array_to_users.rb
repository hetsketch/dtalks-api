class AddSocialLinkArrayToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :links, :string, array: true, default: []
  end
end
