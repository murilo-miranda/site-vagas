class Vacancy < ApplicationRecord
  validates :name, :description, :job_title, :expiration_date,
            :max_vacancies, presence: true
end
