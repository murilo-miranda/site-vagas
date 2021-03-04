require 'rails_helper'

feature 'Employee creates vacancy' do
  scenario 'successfully' do
    company = Company.create!(name: 'Muzak', address: 'Santana',
                              cnpj: '12.345.678/0001-90', site: 'www.muzak.com.br')
    employee = User.create!(email: 'murilo@muzak.com', password: '123456')

    login_as employee
    visit root_path
    click_on 'Minha Empresa'
    click_on 'Vagas'
    click_on 'Criar nova vaga'
    fill_in 'Título', with: 'Desenvolvedor Ruby'
    fill_in 'Descrição', with: 'Procuramos por alguém que saiba Ruby e Rails'
    fill_in 'Faixa Salarial', with: 2500
    choose(option: 'Júnior')
    fill_in 'Requisitos Obrigatórios', with: 'Ruby e Ruby On Rails'
    fill_in 'Data Limite', with: '21/02/2021'
    fill_in 'Total de Vagas', with: 20
    click_on 'Criar'

    expect(current_path).to eq(vacancies_path)
    expect(page).to have_content('Desenvolvedor Ruby')
    expect(page).to have_content('')
    expect(page).to have_content(2500.0)
    expect(page).to have_content('Júnior')
    expect(page).to have_content('')
    expect(page).to have_content('21/02/2021')
    expect(page).to have_content(20)
  end

  scenario 'unsuccessfully - blank fields' do
    company = Company.create!(name: 'Muzak', address: 'Santana',
                              cnpj: '12.345.678/0001-90', site: 'www.muzak.com.br')
    employee = User.create!(email: 'murilo@muzak.com', password: '123456', company: company)

    login_as employee
    visit root_path
    click_on 'Minha Empresa'
    click_on 'Vagas'
    click_on 'Criar nova vaga'
    click_on 'Criar'

    expect(page).to have_content('não pode ficar em branco', count: 5)
  end
end