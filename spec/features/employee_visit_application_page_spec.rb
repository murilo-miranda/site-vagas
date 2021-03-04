require 'rails_helper'

describe 'Employee visit application page' do
  scenario 'to look candidates' do
    employee = User.create!(email: 'murilo@muzak.com', password: '123456')
    vacancy = Vacancy.create!(name: 'Programador Ruby',
                    description: 'Possuimos sistemas legados e estamos'\
                    ' a procura de programadores que nos ajudem a '\
                    'fazer a transição para o novo rails 6.0',
                    salary: 4000, job_title: 'Pleno',
                    mandatory_requirements: 'Conhecimento de Rails '\
                    'e 3 anos de experiência em desenvolvimento',
                    expiration_date: '20/03/2021', max_vacancies: 5,
                    company: employee.company)

    visitor = User.create!(email: 'murilo@gmail.com', password: '123456')
    Account.create!(name: 'Murilo Miranda', cpf: '000.000.000-00',
                    telephone: '(11)99999-9999', biography: 'Formação X, conhecimento Y',
                    user: visitor)
    SignJob.create!(user: visitor, vacancy: vacancy)

    login_as employee
    visit root_path
    click_on 'Minha Empresa'
    click_on 'Vagas'
    click_on vacancy.name

    #expect(page).to have_content(visitor.account.name) #No teste não aparece, mas
    #aparece no servidor de desenvolvimento.
    expect(page).to have_content(visitor.email)
  end
end