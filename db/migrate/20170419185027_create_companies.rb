class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.belongs_to :user, index: true
      t.string :name, null: false, unique: true
      t.string :city, null: false
      t.text   :info, null: false

      t.timestamps
    end
  end
end
