require 'rails_helper'

feature 'Employee creates vacancy' do
  scenario 'successfully' do
    company = Company.create!(name: 'Muzak', address: 'Santana',
                              cnpj: '12.345.678/0001-90', site: 'www.muzak.com.br')
    employee = User.create!(email: 'murilo@muzak', password: '123456', company: company)

    login_as employee
    visit root_path
    click_on 'Minha Empresa'
    click_on 'Vagas'
    click_on 'Criar nova vaga'
    fill_in 'Título', with: 'Desenvolvedor Ruby'
    fill_in 'Descrição', with: ''
    fill_in 'Faixa Salarial', with: 2.500
    choose(option: 'Júnior')
    fill_in 'Requisitos Obrigatórios', with: ''
    fill_in 'Data Limite', with: '21/02/2021'
    fill_in 'Total de Vagas', with: 20
    click_on 'Criar'

    expect(current_path).to eq(vacancy_path(Vacancy.last))
    expect(page).to have_content('Desenvolvedor Ruby')
    expect(page).to have_content('')
    expect(page).to have_content(2.500)
    expect(page).to have_content('Júnior')
    expect(page).to have_content('')
    expect(page).to have_content('21/02/2021')
    expect(page).to have_content(20)
    expect(page).to have_link('Editar')
    expect(page).to have_link('Deletar')
    expect(page).to have_no_button('Criar')
  end

end