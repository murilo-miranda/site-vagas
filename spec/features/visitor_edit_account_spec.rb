require 'rails_helper'

feature 'Visitor edit account' do
  scenario 'successfully' do
    company = Company.create!(name: 'Provisório', address: 'Provisório',
                      cnpj: '12.345.678/0001-90', site: 'www.provisório.com.br')
    visitor = User.create!(email: 'murilo@gmail', password: '123456', company: company)

    login_as visitor
    visit root_path
    click_on 'Meu perfil'
    click_on 'Editar'
    fill_in 'Nome', with: 'Fulano Ciclano da Silva'
    fill_in 'CPF', with: '000.000.000-00'
    fill_in 'Telefone', with: '(11)99999-9999)'
    fill_in 'Resumo', with: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '\
                          'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
    click_on 'Atualizar'

    expect(page).to have_content('Fulano Ciclano da Silva')
    expect(page).to have_content('000.000.000-00')
    expect(page).to have_content('(11)99999-9999)')
  end
end