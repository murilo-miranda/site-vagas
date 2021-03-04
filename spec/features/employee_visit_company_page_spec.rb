require 'rails_helper'

describe 'Employee visit company page' do
  scenario 'and sees all company information' do
    company = Company.create!(name: 'Muzak', address: 'Santana',
                              cnpj: '12.345.678/0001-90', site: 'www.muzak.com.br')
    employee = User.create!(email: 'murilo@muzak', password: '123456', company: company)

    login_as employee
    visit root_path
    click_on 'Minha Empresa'

    expect(current_path).to eq(company_path(company))
    expect(page).to have_content(company.name)
    #expect(page).to have_content(company.logo)
    expect(page).to have_content(company.cnpj)
    expect(page).to have_content(company.address)
    expect(page).to have_content(company.site)
    #expect(page).to have_content(company.social_network) Verificar como mostrar as 3
    expect(page).to have_no_link('Voltar')
  end

  scenario 'and sees all registered vacancies' do
    company = Company.create!(name: 'Muzak', address: 'Santana',
                              cnpj: '12.345.678/0001-90', site: 'www.muzak.com.br')
    employee = User.create!(email: 'murilo@muzak', password: '123456', company: company)
    vacancy1 = Vacancy.create!(name: 'Programador Ruby',
                              description: 'Possuimos sistemas legados e estamos'\
                              ' a procura de programadores que nos ajudem a '\
                              'fazer a transição para o novo rails 6.0',
                              salary: 4000,
                              job_title: 'Pleno',
                              mandatory_requirements: 'Conhecimento de Rails '\
                              'e 3 anos de experiência em desenvolvimento',
                              expiration_date: '20/03/2021', max_vacancies: 5,
                              company: company)
    vacancy2 = Vacancy.create!(name: 'Programador Ruby',
                              description: 'Buscamos desenvolvedor Ruby interessado em ' \
                              'consolidar seus conhecimentos em programação Ruby para ' \
                              'integrar nossa equipe.',
                              salary: 2500,
                              job_title: 'Júnior',
                              mandatory_requirements: 'Experiência com desenvolvimento web '\
                              'usando Ruby on Rails. BDD + Rspec. Javascript. Git.',
                              expiration_date: '20/03/2021', max_vacancies: 5,
                              company: company)

    login_as employee
    visit root_path
    click_on 'Minha Empresa'
    click_on 'Vagas'

    expect(page).to have_content(vacancy1.name)
    expect(page).to have_content(vacancy2.name)
    expect(page).to have_content(vacancy1.job_title)
    expect(page).to have_content(vacancy2.job_title)
    expect(page).to have_content(vacancy1.salary)
    expect(page).to have_content(vacancy2.salary)
    expect(page).to have_content(I18n.l vacancy1.expiration_date)
    expect(page).to have_content(I18n.l vacancy2.expiration_date)
  end

  scenario 'and sees all job application of vacancy' do
    company = Company.create!(name: 'Muzak', address: 'Santana',
                              cnpj: '12.345.678/0001-90', site: 'www.muzak.com.br')
    temporary = Company.create!(name: 'Temporario', address: 'Temporario',
                                cnpj: '12.345.678/0001-91', site: 'www.temporario.com.br')
    employee = User.create!(email: 'murilo@muzak.com', password: '123456', company: company)
    user = User.create!(email: 'murilo@gmail.com', password: '123456', company: temporary)
    user_account = Account.create!(name: 'Murilo Miranda', cpf: '000.000.000-00',
                                  telephone: '(11)99999-9999', biography:'Conhecimento'\
                                  ' A, B e C.', user: user)
    vacancy = Vacancy.create!(name: 'Programador Ruby',
                              description: 'Possuimos sistemas legados e estamos'\
                              ' a procura de programadores que nos ajudem a '\
                              'fazer a transição para o novo rails 6.0',
                              salary: 4000,
                              job_title: 'Pleno',
                              mandatory_requirements: 'Conhecimento de Rails '\
                              'e 3 anos de experiência em desenvolvimento',
                              expiration_date: '20/03/2021', max_vacancies: 5,
                              company: company)
    SignJob.create!(user: user, vacancy: vacancy)

    login_as employee
    visit root_path
    click_on 'Minha Empresa'
    click_on 'Vagas'
    click_on vacancy.name

    expect(page).to have_content(user_account.user.email)
    #expect(page).to have_content(user_account.name)
  end
end