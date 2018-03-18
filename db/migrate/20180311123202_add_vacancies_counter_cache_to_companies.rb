class AddVacanciesCounterCacheToCompanies < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :vacancies_count, :integer, default: 0
  end
end
