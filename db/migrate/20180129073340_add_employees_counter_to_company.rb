class AddEmployeesCounterToCompany < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :employees_count, :integer, default: 0
  end
end
