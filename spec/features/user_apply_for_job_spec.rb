require 'rails_helper'

feature 'User apply for job' do
  scenario 'successfully' do
    temporary_company = Company.create!(name: 'Provisório', address: 'Provisório',
                      cnpj: '12.345.678/0001-90', site: 'www.provisório.com.br')
    muzak_company = Company.create!(name: 'Muzak', address: 'Santana',
                      cnpj: '12.345.678/0001-91', site: 'www.muzak.com.br')
    vacancy = Vacancy.create!(name: 'Desenvolvedor Ruby on Rails',
                      description: 'Nossa empresa procura por desenvolvedores',
                      salary: 2.500, job_title: 'Júnior',
                      mandatory_requirements: 'Conhecimento em Rails 6.0',
                      expiration_date: '21/02/2021', max_vacancies: 20,
                      company: muzak_company)
    visitor = User.create!(email: 'murilo@gmail', password: '123456', company: temporary_company)

    login_as visitor
    visit root_path
    click_on 'Ver mais'
    click_on 'Aplicar'
    click_on 'Minhas inscrições'

    expect(current_path).to eq(applications_accounts_path)
    expect(page).to have_content('Acompanhe suas inscrições')
    expect(page).to have_content(vacancy.name)
    expect(page).to have_content(muzak_company.name)
  end

  scenario 'unsuccessfully - without an account' do
    company = Company.create!(name: 'Muzak', address: 'Santana',
                              cnpj: '12.345.678/0001-90', site: 'www.muzak.com.br')
    vacancy = Vacancy.create!(name: 'Desenvolvedor Ruby on Rails',
                              description: 'Nossa empresa procura por desenvolvedores',
                              salary: 2.500, job_title: 'Júnior',
                              mandatory_requirements: 'Conhecimento em Rails 6.0',
                              expiration_date: '21/02/2021', max_vacancies: 20,
                              company: company)

    visit root_path
    click_on('Ver mais')
    click_on('Aplicar')

    expect(page).to have_content('Você precisa estar logado para fazer essa ação')
    expect(page).to have_content(company.name)
    expect(page).to have_content(vacancy.name)
    expect(page).to have_content(vacancy.description)
    expect(page).to have_content(vacancy.salary)
    expect(page).to have_content(vacancy.job_title)
    expect(page).to have_content(vacancy.mandatory_requirements)
  end
end