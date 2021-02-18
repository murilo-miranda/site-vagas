class HomeController < ApplicationController
  def index
    @vacancies = Vacancy.all
  end
end