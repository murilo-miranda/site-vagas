require 'rails_helper'

describe 'Employee visit company page' do
  scenario 'and sees all information' do
    employee = User.create!(email: 'murilo@muzak', password: '123456')
    company = Company.create!(name: 'Muzak', address: 'Santana',
                              cnpj: '12.345.678/0001-90', site: 'www.muzak.com.br')

    login_as employee
    visit root_path
    click_on 'Minha empresa'
    click_on 'Registro'

    expect(page).to have_content(company.name)
    #expect(page).to have_content(company.logo)
    expect(page).to have_content(company.cnpj)
    expect(page).to have_content(company.address)
    expect(page).to have_content(company.site)
    #expect(page).to have_content(company.social_network) Verificar como mostrar as 3
  end
end