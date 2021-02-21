require 'rails_helper'

feature 'User sign' do
  scenario 'successfully' do

    company = Company.create!(name: 'Muzak', address: 'Santana',
                              cnpj: '12.345.678/0001-90', site: 'www.muzak.com.br')
    user = User.create!(email: 'murilo@muzak', password: '123456',
                            company: company)

    visit root_path
    click_on 'Entrar'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Entrar'

    expect(page).to have_content 'Login efetuado com sucesso!'
    expect(page).to have_content user.email
    expect(page).to have_link 'Sair'
    expect(page).not_to have_link 'Entrar'
  end

  scenario 'unsuccessfully - blank field' do

    visit root_path
    click_on 'Entrar'
    click_button 'Entrar'

    expect(page).to have_content 'E-mail ou senha inválida.'
  end
end