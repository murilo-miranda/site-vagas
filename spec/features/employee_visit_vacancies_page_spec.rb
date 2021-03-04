require 'rails_helper'

feature 'Employee visit vacancies page' do
  scenario 'and sees all vacancies' do
    muzak_comp = Company.create!(name: 'Muzak', address: 'Santana',
                              cnpj: '12.345.678/0001-90', site: 'www.muzak.com.br')
    kaiba_comp = Company.create!(name: 'Kaiba Corp', address: 'Domino City',
                cnpj: '01.234.567/0001-80', site: 'www.kaibacorp.com.br')
    employee = User.create!(email: 'murilo@muzak.com', password: '123456')
    employee.company = muzak_comp
    employee.save
    vacancy1 = Vacancy.create!(name: 'Desenvolvedor Ruby on Rails',
                              description: 'Nossa empresa procura por desenvolvedores',
                              salary: 2.500, job_title: 'Júnior',
                              mandatory_requirements: 'Conhecimento em Rails 6.0',
                              expiration_date: '21/02/2021', max_vacancies: 20,
                              company: muzak_comp)
    vacancy2 = Vacancy.create!(name: 'Duel Disk connection',
                              description: 'Kaiba Corp é conhecida pelo seu produto Duel Disk'\
                              ' , e estamos a procura de programadores para integrar nosso '\
                              'produto com os nossos parceiros.',
                              salary: 4500,
                              job_title: 'Pleno',
                              mandatory_requirements: 'Conhecimentos em API e nosso querido '\
                              'produto.',
                              expiration_date: '20/03/2021', max_vacancies: 3,
                              company: kaiba_comp)

    login_as employee
    visit root_path
    click_on 'Minha Empresa'
    click_on 'Vagas'

    expect(page).to have_content(vacancy1.name)
    expect(page).to have_content(vacancy1.job_title)
    expect(page).to have_content(I18n.l vacancy1.expiration_date)
    expect(page).to have_content(vacancy1.max_vacancies)
    expect(page).to have_no_content(vacancy2.name)
    expect(page).to have_no_content(vacancy2.job_title)
    expect(page).to have_no_content(I18n.l vacancy2.expiration_date)
    expect(page).to have_no_content(vacancy2.max_vacancies)
  end
end