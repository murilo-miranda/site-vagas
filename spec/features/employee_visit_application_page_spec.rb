require 'rails_helper'

describe 'Employee visit application page' do
  scenario 'to look candidates' do
    temporary_company = Company.create!(name: 'Temporário', cnpj: '12.345.678/0001-91',
                                    site: 'temporário.com.br')
    muzak_company = Company.create!(name: 'Muzak', address: 'Santana',
                                    cnpj: '12.345.678/0001-90', site: 'www.muzak.com.br')
    vacancy = Vacancy.create!(name: 'Programador Ruby',
                    description: 'Possuimos sistemas legados e estamos'\
                    ' a procura de programadores que nos ajudem a '\
                    'fazer a transição para o novo rails 6.0',
                    salary: 4000, job_title: 'Pleno',
                    mandatory_requirements: 'Conhecimento de Rails '\
                    'e 3 anos de experiência em desenvolvimento',
                    expiration_date: '20/03/2021', max_vacancies: 5,
                    company: muzak_company)
    employee = User.create!(email: 'murilo@muzak', password: '123456', company: muzak_company)
    visitor = User.create!(email: 'murilo@gmail', password: '123456', company: temporary_company)
    SignJob.create!(user: visitor, vacancy: vacancy)
    visitor_account = Account.create!(name: 'Murilo Miranda', cpf: '000.000.000-00',
                                      telephone: '(11)99999-9999',
                                      biography: 'Formação X, conhecimento Y',
                                      user: visitor)

    login_as employee
    visit root_path
    click_on 'Minha Empresa'
    click_on 'Vagas'
    click_on vacancy.name
    click_on 'Ver candidatos'

    expect(page).to have_content(visitor.email)
    expect(page).to have_content(visitor.account.name)
  end
end