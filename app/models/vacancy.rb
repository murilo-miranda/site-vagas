class Vacancy < ApplicationRecord
  belongs_to :company
  has_many :sign_jobs
  has_many :users, through: :sign_jobs

  validates :name, :description, :job_title, :expiration_date,
            :max_vacancies, presence: true
end
