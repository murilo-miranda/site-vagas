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

  xscenario 'and sees all registered vacancies' do

  end

  xscenario 'and sees all job application' do

  end
end