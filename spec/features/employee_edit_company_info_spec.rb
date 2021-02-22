require 'rails_helper'

feature 'Employee edit company info' do
  scenario 'successfully' do
    company = Company.create!(name: 'Muzak', address: 'Santana',
                              cnpj: '12.345.678/0001-90', site: 'www.muzak.com.br')
    employee = User.create!(email: 'murilo@muzak', password: '123456', company: company)

    #social_network
    #logo

    login_as employee
    visit root_path
    click_on 'Minha Empresa'
    click_on 'Editar'
    fill_in 'Nome', with: 'Macrohard'
    attach_file 'Logo', Rails.root.join('spec', 'support', 'kc.jpg')
    fill_in 'Endereço', with: 'Liberdade'
    fill_in 'Página Web', with: 'www.macrohard.com.br'
    click_on 'Atualizar Empresa'

    expect(page).to have_content('Macrohard')
    expect(page).to have_css('img[src*="kc.jpg"]')
    expect(page).to have_content('Liberdade')
    expect(page).to have_content('www.macrohard.com.br')
    expect(page).to have_content('12.345.678/0001-90')
    expect(page).to have_no_button('Atualizar Empresa')
  end

  scenario 'unsuccessfully - specific field cannot be blank' do
    company = Company.create!(name: 'Muzak', address: 'Santana',
                              cnpj: '12.345.678/0001-90', site: 'www.muzak.com.br')
    employee = User.create!(email: 'murilo@muzak', password: '123456', company: company)

    login_as employee
    visit root_path
    click_on 'Minha Empresa'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Página Web', with: ''
    click_on 'Atualizar Empresa'

    expect(page).to have_content('não pode ficar em branco', :count => 3)
    expect(page).to have_button('Atualizar Empresa')
  end

  xscenario 'uploading a logo' do
  end
end