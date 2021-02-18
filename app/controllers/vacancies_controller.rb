class VacanciesController < ApplicationController
  def index
    @vacancies = Vacancy.all
  end

  def new
    @vacancy = Vacancy.new
  end

  def create
    @vacancy = Vacancy.new(vacancy_params)

    if @vacancy.save
      redirect_to vacancies_path
    else
      render :new
    end
  end

  def show
    @vacancy = Vacancy.find(params[:id])
    #Retirar linha abaixo após fazer associações
    @company = Company.last
  end

  private

  def vacancy_params
      params.require(:vacancy).permit(:name, :description, :salary, :job_title,
      :mandatory_requirements, :expiration_date, :max_vacancies)
    end
end