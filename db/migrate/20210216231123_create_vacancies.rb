class CreateVacancies < ActiveRecord::Migration[6.1]
  def change
    create_table :vacancies do |t|
      t.string :name
      t.text :description
      t.decimal :salary
      t.string :job_title
      t.text :mandatory_requirements
      t.date :expiration_date
      t.integer :max_vacancies

      t.timestamps
    end
  end
end
