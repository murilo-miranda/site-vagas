class VacancyController < ApplicationController
  def index
    @vacancies = Vacancy.all
  end

  def new
  end
end