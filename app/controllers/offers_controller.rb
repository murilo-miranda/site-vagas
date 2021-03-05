class OffersController < ApplicationController
  $user_param
  $vacancy_param

  def new
    @offer = Offer.new()
    $user_param =  params[:user]
    $vacancy_param = params[:vacancy]
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.user_id = $user_param
    @offer.vacancy_id = $vacancy_param

    if @offer.save
      flash[:notice] = 'Proposta enviada com sucesso'
      @offer.approved!
      redirect_to vacancies_path
    else
      render :new
    end
  end

  def show
    @offers = Offer.where(user: current_user, vacancy: params[:id])
  end

  private
    def offer_params
      params.require(:offer).permit(:reason, :start_date, :salary, :status)
    end
end