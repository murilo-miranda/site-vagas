require 'rails_helper'

feature 'User visit homepage' do
  scenario 'and sees all vacancies' do
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
                              expiration_date: '20/03/2021', max_vacancies: 5,
                              company: company)

    visit root_path

    expect(page).to have_content('Home')
    expect(page).to have_content('Vagas')
    expect(page).to have_content(company.name)
    expect(page).to have_content(vacancy.name)
    expect(page).to have_content(vacancy.job_title)
    expect(page).to have_content(vacancy.salary)
  end

  scenario 'and see no vacancy' do

    visit root_path

    expect(page).to have_content('Home')
    expect(page).to have_content('Vagas')
    expect(page).to have_content('Não há vagas registradas')
  end

  scenario 'and must not see inactive vacancy nor expirated' do
    company = Company.create!(name: 'Muzak', address: 'Santana',
                              cnpj: '12.345.678/0001-90', site: 'www.muzak.com.br')
    vacancy1 = Vacancy.create!(name: 'Programador Ruby',
                              description: 'Possuimos sistemas legados e estamos'\
                              ' a procura de programadores que nos ajudem a '\
                              'fazer a transição para o novo rails 6.0',
                              salary: 3000,
                              job_title: 'Pleno',
                              mandatory_requirements: 'Conhecimento de Rails '\
                              'e 2 anos de experiência em desenvolvimento',
                              expiration_date: '20/03/2021', max_vacancies: 5,
                              company: company)
    vacancy2 = Vacancy.create!(name: 'Programador PHP',
                              description: 'Desejamos criar um novo sistema'\
                              ' e estamos procurando um desenvolvedor PHP '\
                              'para fazer parte do nosso time',
                              salary: 3000,
                              job_title: 'Pleno',
                              mandatory_requirements: 'Conhecimento de PHP '\
                              'e 2 anos de experiência em desenvolvimento',
                              expiration_date: '03/03/2021', max_vacancies: 5,
                              company: company)

    visit root_path

    expect(page).to have_content(vacancy1.name)
    expect(page).to have_no_content(vacancy2.name)
  end

  scenario 'and check for more information' do
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
                              expiration_date: '20/03/2021', max_vacancies: 5,
                              company: company)

    visit root_path
    click_on('Ver mais')

    expect(page).to have_content(company.name)
    expect(page).to have_content(vacancy.name)
    expect(page).to have_content(vacancy.description)
    expect(page).to have_content(vacancy.salary)
    expect(page).to have_content(vacancy.job_title)
    expect(page).to have_content(vacancy.mandatory_requirements)
    expect(page).to have_link('Voltar')
    click_on ('Voltar')
    expect(current_path).to eq(root_path)
  end

  scenario 'and check for company information' do
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
                              expiration_date: '20/03/2021', max_vacancies: 5,
                              company: company)

    visit root_path
    click_on('Ver mais')
    click_on(company.name)

    expect(page).to have_content(company.name)
    expect(page).to have_content(company.address)
    expect(page).to have_content(company.cnpj)
    expect(page).to have_content(company.site)
    expect(page).to have_no_link('Vagas')
    expect(page).to have_no_link('Candidatura')
    expect(page).to have_no_link('Editar')
    expect(page).to have_link('Voltar')
  end

  scenario 'logged in' do
    company = Company.create!(name: 'Provisório', address: 'Provisório',
                      cnpj: '12.345.678/0001-90', site: 'www.provisório.com.br')
    visitor = User.create!(email: 'murilo@gmail', password: '123456', company: company)


    login_as visitor
    visit root_path
    expect(page).to have_no_link('Minha Empresa')
    expect(page).to have_link('Meu perfil')
    expect(page).to have_link('Sair')
  end
end