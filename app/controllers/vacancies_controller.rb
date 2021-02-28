class VacanciesController < ApplicationController
  def index
    @company = current_user.company
    @vacancies = Vacancy.where(company: @company)
  end

  def new
    @vacancy = Vacancy.new
  end

  def create
    @vacancy = Vacancy.new(vacancy_params)
    @vacancy.company = current_user.company

    if @vacancy.save
      redirect_to vacancies_path
    else
      render :new
    end
  end

  def show
    @vacancy = Vacancy.find(params[:id])
    #Retirar linha abaixo após fazer associações
    @company = Company.find_by(vacancy: @vacancy)
  end

  def apply
    @vacancy = Vacancy.find(params[:id])
    if user_signed_in?
      SignJob.create!(user: current_user, vacancy: @vacancy)
      flash[:sign_job_notice] = 'Inscrição realizada com sucesso'
      redirect_to applications_accounts_path
    else
      flash[:sign_job_notice] = 'Você precisa estar logado para fazer essa ação'
      redirect_to vacancy_path(@vacancy)
    end
  end

  def candidates
  end

  private

  def vacancy_params
      params.require(:vacancy).permit(:name, :description, :salary, :job_title,
      :mandatory_requirements, :expiration_date, :max_vacancies)
    end
end