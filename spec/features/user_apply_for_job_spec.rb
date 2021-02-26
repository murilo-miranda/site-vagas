require 'rails_helper'

feature 'User apply for job' do
  xscenario 'successfully' do
    company = Company.create!(name: 'Provisório', address: 'Provisório',
                      cnpj: '12.345.678/0001-90', site: 'www.provisório.com.br')
    visitor = User.create!(email: 'murilo@gmail', password: '123456', company: company)


  end

  xscenario 'unsuccessfully - without an account' do
    company = Company.create!(name: 'Muzak', address: 'Santana',
                              cnpj: '12.345.678/0001-90', site: 'www.muzak.com.br')
    vacancy = Vacancy.create!(name: 'Programador Ruby',
                              description: 'Possuimos sistemas legados e estamos'\
                              ' a procura de programadores que nos ajudem a '\
                              'fazer a transição para o novo rails 6.0',
                              salary: 3000,
                              job_title: 'Pleno',
                              mandatory_requirements: 'Conhecimento de Rails '\
                              'e 2 anos de experiência em desenvolvimento',
                              expiration_date: '20/03/2021', max_vacancies: 5)

    visit root_path
    click_on('Ver mais')
    click_on('Candidatar-se')

    expect(page).to have_content('Você precisa estar logado para fazer essa ação')
    expect(page).to have_content(company.name)
    expect(page).to have_content(vacancy.name)
    expect(page).to have_content(vacancy.description)
    expect(page).to have_content(vacancy.salary)
    expect(page).to have_content(vacancy.job_title)
    expect(page).to have_content(vacancy.mandatory_requirements)
  end
end