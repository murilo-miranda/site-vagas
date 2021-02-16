require 'rails_helper'

feature 'Employee visit vacancies page' do
  scenario 'and sees all vacancies' do
    company = Company.create!(name: 'Muzak', address: 'Santana',
                              cnpj: '12.345.678/0001-90', site: 'www.muzak.com.br')
    employee = User.create!(email: 'murilo@muzak', password: '123456', company: company)
    vacancy = Vacancy.create!(name: 'Desenvolvedor Ruby on Rails',
                              description: 'Nossa empresa procura por desenvolvedores',
                              salary: 2.500, job_title: 'Júnior',
                              mandatory_requirements: 'Conhecimento em Rails 6.0',
                              expiration_date: '21/02/2021', max_vacancies: 20)

    login_as employee
    visit root_path
    click_on 'Minha Empresa'
    click_on 'Vagas'

    expect(page).to have_content(vacancy.name)
    expect(page).to have_content(vacancy.job_title)
    expect(page).to have_content(vacancy.expiration_date)
    expect(page).to have_content(vacancy.max_vacancies)
  end
end