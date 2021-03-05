class CompaniesController < ApplicationController
  def show
    if user_signed_in?
      user = current_user.company.id
      @company = Company.find_by(id: user)
    else
      @company = Company.find(params[:id])
    end
  end

  def edit
    if user_signed_in?
      user = current_user.company.id
      @company = Company.find_by(id: user)
    end
  end

  def update
    @company = Company.find(params[:id])

    if @company.update(company_params)
      redirect_to @company
    else
      render :edit
    end
  end

  private

    def company_params
      params.require(:company).permit(:name, :logo, :address, :cnpj, :site,
                                      :social_network)
    end
end