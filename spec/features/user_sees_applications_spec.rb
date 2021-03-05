require 'rails_helper'

feature 'User sees applications' do
  scenario 'proposal received' do
    visitor = User.create!(email: 'murilo@gmail.com', password: '123456')
    muzak_comp = Company.create!(name: 'Muzak', address: 'Santana',
                              cnpj: '12.345.678/0001-90', site: 'www.muzak.com.br')
    vacancy = Vacancy.create!(name: 'Desenvolvedor Ruby on Rails',
                              description: 'Nossa empresa procura por desenvolvedores',
                              salary: 2.500, job_title: 'Júnior',
                              mandatory_requirements: 'Conhecimento em Rails 6.0',
                              expiration_date: '21/02/2021', max_vacancies: 20,
                              company: muzak_comp)
    offer = Offer.create!(reason: 'Gostamos do seu perfil', start_date: '30/03/2021',
                          salary: 3000, user: visitor, vacancy: vacancy)
    SignJob.create!(user: visitor, vacancy: vacancy)

    login_as visitor
    visit root_path
    click_on 'Minhas inscrições'
    click_on vacancy.name

    expect(page).to have_content('aprovado')
    expect(page).to have_content(offer.reason)
    expect(page).to have_content(offer.start_date)
    expect(page).to have_content(offer.salary)
  end
end