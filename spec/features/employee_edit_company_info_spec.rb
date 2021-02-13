require 'rails_helper'

feature 'Employee edit company info' do
  scenario 'successfully' do
    employee = User.create!(email: 'murilo@muzak', password: '123456')
    company = Company.create!(name: 'Muzak', address: 'Santana',
                              cnpj: '12.345.678/0001-90', site: 'www.muzak.com.br')

    login_as employee
    visit root_path
    click_on 'Minha Empresa'
    click_on 'Editar'
    fill_in 'Nome', with: 'Macrohard'
    fill_in 'Endereço', with: 'Liberdade'
    fill_in 'Site', with: 'www.macrohard.com.br'
    click_on 'Salvar'

    expect(page).to have_content('Informações salvas')
    expect(page).to have_content('Macrohard')
    expect(page).to have_content('Liberdade')
    expect(page).to have_content('www.macrohard.com.br')
    expect(page).to have_content('12.345.678/0001-90')
    expect(page).to have_no_link('Salvar')
  end

  scenario 'unsuccessfully - specific field cannot be blank' do
    employee = User.create!(email: 'murilo@muzak', password: '123456')
    company = Company.create!(name: 'Muzak', address: 'Santana',
                              cnpj: '12.345.678/0001-90', site: 'www.muzak.com.br')

    login_as employee
    visit root_path
    click_on 'Minha Empresa'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Site', with: ''
    click_on 'Salvar'

    expect(page).to have_content('Não pode ser em branco', :count => 3)
    expect(page).to have_link('Salvar')
  end
end