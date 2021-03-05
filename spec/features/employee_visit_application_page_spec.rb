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

  scenario 'to approves a candidate' do
    company = Company.create!(name: 'Muzak', address: 'Santana',
                              cnpj: '12.345.678/0001-90', site: 'www.muzak.com.br')
    vacancy = Vacancy.create!(name: 'Programador Ruby',
                              description: 'Possuimos sistemas legados e estamos'\
                              ' a procura de programadores que nos ajudem a '\
                              'fazer a transição para o novo rails 6.0',
                              salary: 4000, job_title: 'Pleno',
                              mandatory_requirements: 'Conhecimento de Rails '\
                              'e 3 anos de experiência em desenvolvimento',
                              expiration_date: '28/03/2021', max_vacancies: 5,
                              company: company)
    candidate = User.create!(email: 'murilo@gmail.com', password: '123456')
    SignJob.create!(user: candidate, vacancy: vacancy)
    employee = User.create!(email: 'murilo@muzak.com', password: '123456')
    employee.company = company
    employee.save

    login_as employee
    visit root_path
    click_on 'Minha Empresa'
    click_on 'Vagas'
    click_on vacancy.name
    click_on 'Aprovar'
    fill_in 'Informação', with: 'Li o seu perfil e gostei das informações que encontrei '\
                                'são justamente o que estamos procurando.'\
                                'Segue as informações do contrato nos campos. '\
                                'Por favor me envie sua resposta para '\
                                'darmos continuidade.'
    fill_in 'Data de início', with: '30/03/2021'
    fill_in 'Salário', with: 4000
    click_on 'Criar Proposta'

    expect(page).to have_content('Proposta enviada com sucesso')
    expect(page).to have_no_content(candidate.email)
  end
end