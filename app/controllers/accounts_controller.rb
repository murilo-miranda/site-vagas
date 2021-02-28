class AccountsController < ApplicationController
  def show
    @account = Account.find_by(user: current_user.id)
  end

  def edit
    @account = Account.find_by(user: current_user.id)
  end

  def update
    @account = Account.find_by(user: current_user.id)

    if @account.update(account_params)
      redirect_to @account
    else
      render :edit
    end
  end

  def applications
    applications_account = SignJob.where(user: current_user.id)
    vacancies_ids = []

    applications_account.map do |application|
      vacancies_ids << application.vacancy.id
    end

    @vacancies = Vacancy.where(id: vacancies_ids)
  end

  private

    def account_params
      params.require(:account).permit(:name, :cpf, :telephone, :biography)
    end
end